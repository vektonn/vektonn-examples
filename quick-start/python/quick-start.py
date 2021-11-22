from vektonn import Vektonn
from vektonn.dtos import AttributeDto, AttributeValueDto, VectorDto, InputDataPointDto, SearchQueryDto

vektonn_client = Vektonn('http://localhost:8081')

input_data_points = [
    InputDataPointDto(
        attributes=[
            AttributeDto(key='id', value=AttributeValueDto(int64=1)),
            AttributeDto(key='payload', value=AttributeValueDto(string='first data point')),
        ],
        vector=VectorDto(is_sparse=False, coordinates=[0.0, 1.0])),
    InputDataPointDto(
        attributes=[
            AttributeDto(key='id', value=AttributeValueDto(int64=2)),
            AttributeDto(key='payload', value=AttributeValueDto(string='second data point')),
        ],
        vector=VectorDto(is_sparse=False, coordinates=[1.0, 0.0])),
    InputDataPointDto(
        attributes=[
            AttributeDto(key='id', value=AttributeValueDto(int64=3)),
            AttributeDto(key='payload', value=AttributeValueDto(string='third data point')),
        ],
        vector=VectorDto(is_sparse=False, coordinates=[-0.5, 0.0])),
]

vektonn_client.upload(
    data_source_name='QuickStart.Source',
    data_source_version='1.0',
    input_data_points=input_data_points)

k = 2
search_query = SearchQueryDto(k=k, query_vectors=[
    VectorDto(is_sparse=False, coordinates=[0.0, 2.0]),
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
