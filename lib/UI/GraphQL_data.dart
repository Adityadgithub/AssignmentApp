import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLdata extends StatelessWidget {
  const GraphQLdata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/');
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));
    return GraphQLProvider(
      child: DataPage(),
      client: client,
    );
  }
}

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GraphQL data'),
      ),
      body: Query(
          options: QueryOptions(document: gql(r"""
            query {
              continents{
                name
              }
            }

""")),
          builder: (result, {fetchMore, refetch}) {
            if (result.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'CONTINENTS',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  Expanded(
                    child: ListView.builder(
                      itemCount: result.data!['continents'].length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              "${index+1}. ",
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              "${result.data!['continents'][index]['name']}",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
