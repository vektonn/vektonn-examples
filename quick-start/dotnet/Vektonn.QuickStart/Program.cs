using System.Globalization;
using Vektonn.ApiClient;
using Vektonn.ApiContracts;
using Vostok.Logging.Abstractions;

var vektonnClient = new VektonnApiClient(new Uri("http://localhost:8081"), new SilentLog());

var inputDataPoints = new[] {
    new InputDataPointDto(
        Attributes: new[] {
            new AttributeDto(Key: "id", Value: new AttributeValueDto(Int64: 1)),
            new AttributeDto(Key: "payload", Value: new AttributeValueDto(String: "first data point")),
        },
        Vector: new DenseVectorDto(Coordinates: new[] { 0.0, 1.0 }),
        IsDeleted: false),
    new InputDataPointDto(
        Attributes: new[] {
            new AttributeDto(Key: "id", Value: new AttributeValueDto(Int64: 2)),
            new AttributeDto(Key: "payload", Value: new AttributeValueDto(String: "second data point")),
        },
        Vector: new DenseVectorDto(Coordinates: new[] { 1.0, 0.0 }),
        IsDeleted: false),
    new InputDataPointDto(
        Attributes: new[] {
            new AttributeDto(Key: "id", Value: new AttributeValueDto(Int64: 3)),
            new AttributeDto(Key: "payload", Value: new AttributeValueDto(String: "third data point")),
        },
        Vector: new DenseVectorDto(Coordinates: new[] { -0.5, 0.0 }),
        IsDeleted: false),
};

await vektonnClient.UploadAsync(
    dataSourceName: "QuickStart.Source",
    dataSourceVersion: "1.0",
    inputDataPoints);

const int k = 2;
var searchQuery = new SearchQueryDto(
    K: k,
    QueryVectors: new[] { new DenseVectorDto(Coordinates: new[] { 0.0, 2.0 }) },
    SplitFilter: null
);

var searchResults = await vektonnClient.SearchAsync(
    indexName: "QuickStart.Index",
    indexVersion: "1.0",
    searchQuery);

Console.WriteLine($"For query vector {FormatCoordinates(searchResults[0].QueryVector)} {k} nearest data points are:");
foreach (var fdp in searchResults[0].NearestDataPoints)
{
    var attrs = fdp.Attributes.ToDictionary(t => t.Key, t => t.Value);
    Console.WriteLine($" - '{attrs["payload"].String}' with " +
        $"id = {attrs["id"].Int64}, " +
        $"vector = {FormatCoordinates(fdp.Vector)}, " +
        $"distance = {fdp.Distance}");
}

static string FormatCoordinates(VectorDto vector) =>
    $"[{string.Join(", ", vector.Coordinates.Select(x => x.ToString("F1", CultureInfo.InvariantCulture)))}]";


/*
Expected output:

For query vector [0.0, 2.0] 2 nearest data points are:
 - 'first data point' with id = 1, vector = [0.0, 1.0], distance = 1
 - 'third data point' with id = 3, vector = [-0.5, 0.0], distance = 4.25
*/
