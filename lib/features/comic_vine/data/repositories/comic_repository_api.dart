import 'package:comic_vine_app/core/contracts/i_comic_repository.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';
import 'package:comic_vine_app/features/comic_vine/domain/entities/info_item.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:comic_vine_app/core/contracts/i_app_config.dart';
import 'package:xml/xml.dart' as xml;

/// Implementation of ComicRepository that fetches data from the Comic Vine API
class ComicRepositoryAPI implements ComicRepository {
  final IAppConfig config = GetIt.I<IAppConfig>();

  /// Fetches a list of comics from the Comic Vine API
  @override
  Future<List<ComicModel>> fetchComics() async {
    final String url = '${config.baseUrl}/issues/?api_key=${config.apiKey}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final issues = document.findAllElements('issue');

        // Map each issue to a ComicModel instance
        return issues.map((issue) {
          return ComicModel(
            id: int.parse(issue.findElements('id').first.text),
            name: _extractText(issue.findElements('volume').first, 'name'),
            issueNumber: _extractText(issue, 'issue_number'),
            coverDate: _extractText(issue, 'cover_date'),
            description: _extractText(issue, 'description'),
            imageUrl: _extractImageURL(issue),
            volumeId: int.parse(issue.findElements('volume').first.findElements('id').first.text),
            volumeName: _extractText(issue.findElements('volume').first, 'name'),
          );
        }).toList();
      } else {
        throw Exception('Failed to load comics');
      }
    } catch (e) {
      throw Exception('Error fetching comics: $e');
    }
  }

  /// Fetches details of a specific comic by its ID
  @override
  Future<ComicModel> fetchComicDetail(int id) async {
    final String url = '${config.baseUrl}/issue/4000-$id/?api_key=${config.apiKey}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the XML document from the response
        final document = xml.XmlDocument.parse(response.body);
        // Get the first <results> element which contains the issue details
        final results = document.findAllElements('results').first;
        // Fetch detailed info for characters, concepts, etc.
        final creators = await _fetchDetailedItems(results, 'person_credits', 'person');
        final characters = await _fetchDetailedItems(results, 'character_credits', 'character');
        final teams = await _fetchDetailedItems(results, 'team_credits', 'team');
        final locations = await _fetchDetailedItems(results, 'location_credits', 'location');
        final concepts = await _fetchDetailedItems(results, 'concept_credits', 'concept');

        // Return a ComicModel from the parsed XML data
        return ComicModel(
          id: int.parse(results.findElements('id').first.text),
          name: _extractText(results.findElements('volume').first, 'name'),
          issueNumber: _extractText(results, 'issue_number'),
          coverDate: _extractText(results, 'cover_date'),
          description: _extractText(results, 'description'),
          imageUrl: _extractImageURL(results),
          volumeId: int.parse(results.findElements('volume').first.findElements('id').first.text),
          volumeName: _extractText(results.findElements('volume').first, 'name'),
          creators: creators,
          characters: characters,
          teams: teams,
          locations: locations,
          concepts: concepts,
        );
      } else {
        throw Exception('Failed to load comic details');
      }
    } catch (e) {
      throw Exception('Error fetching comic details: $e');
    }
  }

  // Helper function to fetch detailed info from the `api_detail_url` for each item (character, concept, etc.)
  Future<List<InfoItem>> _fetchDetailedItems(xml.XmlElement element, String sectionTag, String itemTag) async {
    final section = element.findElements(sectionTag).firstOrNull;
    if (section != null) {
      final List<InfoItem> detailedItems = [];
      for (var item in section.findElements(itemTag)) {
        final String apiDetailUrl = item.findElements('api_detail_url').first.text;
        final String role = item.findElements('role').isNotEmpty
            ? item.findElements('role').first.text
            : '';
        final detailedInfo = await _fetchDetailedItem(apiDetailUrl,role); // Fetch additional details from the URL
        detailedItems.add(detailedInfo);
      }
      return detailedItems;
    }
    return [];
  }

  // Helper function to fetch details from the `api_detail_url`
  Future<InfoItem> _fetchDetailedItem(String url, String role) async {
    try {
      String urlFetch = '$url?api_key=${config.apiKey}';
      final response = await http.get(Uri.parse(urlFetch));
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final item = document.findAllElements('results').first;

        return InfoItem(
          name: _extractText(item, 'name'),
          description: role,
          imageUrl: _extractImageURL(item), // Assuming there's an image in the response
        );
      } else {
        throw Exception('Failed to fetch detailed item from $url');
      }
    } catch (e) {
      throw Exception('Error fetching detailed item from $url: $e');
    }
  }


  /// Helper method to extract text from a specific XML element
  String _extractText(xml.XmlElement element, String tagName) {
    try {
      return element.findElements(tagName).first.text;
    } catch (e) {
      return 'Unknown'; // Default value if the element is missing
    }
  }

  /// Helper method to extract the image URL from the XML structure
  String _extractImageURL(xml.XmlElement element) {
    try {
      return element.findElements('image').first.findElements('medium_url').first.text;
    } catch (e) {
      return 'https://default-image-url.com'; // Default image if missing
    }
  }

  // Helper to extract InfoItems (creators, characters, etc.)
  List<InfoItem> _extractInfoItems(xml.XmlElement element, String sectionTag, String itemTag) {
    final section = element.findElements(sectionTag).firstOrNull;
    if (section != null) {
      return section.findElements(itemTag).map((item) {
        return InfoItem(
          name: _extractText(item, 'name'),
          description: _extractText(item, 'role'), // For creators like 'writer', 'penciler', etc.
          imageUrl: _extractText(item, 'site_detail_url'), // Or some other image source if available
        );
      }).toList();
    }
    return [];
  }
}
