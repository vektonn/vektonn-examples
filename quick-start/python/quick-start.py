from vektonn import Vektonn
from vektonn.dtos import Attribute, AttributeValue, Vector, InputDataPoint, SearchQuery

vektonn_client = Vektonn('http://localhost:8081')

input_data_points = [
    InputDataPoint(
        attributes=[
            Attribute(key='id', value=AttributeValue(int64=1)),
            Attribute(key='payload', value=AttributeValue(string='first data point')),
        ],
        vector=Vector(is_sparse=False, coordinates=[0.0, 1.0])),
    InputDataPoint(
        attributes=[
            Attribute(key='id', value=AttributeValue(int64=2)),
            Attribute(key='payload', value=AttributeValue(string='second data point')),
        ],
        vector=Vector(is_sparse=False, coordinates=[1.0, 0.0])),
    InputDataPoint(
        attributes=[
            Attribute(key='id', value=AttributeValue(int64=3)),
            Attribute(key='payload', value=AttributeValue(string='third data point')),
        ],
        vector=Vector(is_sparse=False, coordinates=[-0.5, 0.0])),
]

vektonn_client.upload(
    data_source_name='QuickStart.Source',
    data_source_version='1.0',
    input_data_points=input_data_points)

k = 2
search_query = SearchQuery(k=k, query_vectors=[
    Vector(is_sparse=False, coordinates=[0.0, 2.0]),
])

search_results = vektonn_client.search(
    index_name='QuickStart.Index',
    index_version='1.0',
    search_query=search_query)

print(f'For query vector {search_results[0].query_vector.coordinates} {k} nearest data points are:')
for fdp in search_results[0].nearest_data_points:
    attrs = {x.key : x.value for x in fdp.attributes}
    distance, vector, dp_id, payload = fdp.distance, fdp.vector, attrs['id'].int64, attrs['payload'].string
    print(f' - "{payload}" with id = {dp_id}, vector = {vector.coordinates}, distance = {distance}')

'''
Expected output:

For query vector [0.0, 2.0] 2 nearest data points are:
 - "first data point" with id = 1, vector = [0.0, 1.0], distance = 1.0
 - "third data point" with id = 3, vector = [-0.5, 0.0], distance = 4.25
'''
