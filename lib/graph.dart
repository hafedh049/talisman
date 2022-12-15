import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:graphview/GraphView.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class GraphPlotting extends StatefulWidget {
  const GraphPlotting({Key? key}) : super(key: key);

  @override
  State<GraphPlotting> createState() => _GraphPlottingState();
}

class _GraphPlottingState extends State<GraphPlotting> {
  TextEditingController nodeController = TextEditingController(text: "");
  Graph graph = Graph();
  Map<String, Color> nodesMap = <String, Color>{};
  FruchtermanReingoldAlgorithm algorithm = FruchtermanReingoldAlgorithm();
  Color nodeColor = Colors.white;
  String firstNode = "SourceNode";
  String secondNode = "DestinationNode";
  Color edgeColor = Colors.white;
  double edgeStroke = 1;
  String nodeId = "";

  @override
  void dispose() {
    nodeController.dispose();
    super.dispose();
  }

  Widget displayNode({required String data, required Color color}) {
    return InkWell(
      onTap: () {
        setState(() {
          nodeId = data;
        });
      },
      child: Text(
        data,
        style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          shadows: const <Shadow>[
            Shadow(blurRadius: 14, color: Colors.pink),
            Shadow(blurRadius: 14, color: Colors.blue),
            Shadow(blurRadius: 14, color: Colors.green),
          ],
        ),
      ),
    );
  }

  StatefulBuilder displayAddEdge() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "ADD EDGES",
          style: TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  "First Node",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: DropdownButton<String>(
                  value: firstNode,
                  items: nodesMap.keys.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(color: nodesMap[e], fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      firstNode = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  "Second Node",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: DropdownButton<String>(
                  value: secondNode,
                  items: nodesMap.keys
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(color: nodesMap[e], fontSize: 20),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      secondNode = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              BlockPicker(
                pickerColor: Colors.green,
                onColorChanged: (Color color) {
                  edgeColor = color;
                },
              ),
              const SizedBox(
                height: 3,
              ),
              Slider(
                  min: 1,
                  max: 10,
                  value: edgeStroke,
                  divisions: 10,
                  label: edgeStroke.toString(),
                  onChanged: (double? value) {
                    setState(
                      () {
                        edgeStroke = value!;
                      },
                    );
                  }),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          MaterialButton(
            onPressed: () {
              if (firstNode != "SourceNode" &&
                  secondNode != "DestinationNode") {
                var paint = Paint()
                  ..color = edgeColor
                  ..strokeWidth = edgeStroke;
                setState(() {
                  graph.addEdge(graph.getNodeUsingId(firstNode),
                      graph.getNodeUsingId(secondNode),
                      paint: paint);
                });
              }
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.red,
                ),
                Text(
                  "ADD",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  StatefulBuilder displayRemoveNode() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "REMOVE NODES",
          style: TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              for (var key in nodesMap.keys)
                InkWell(
                  onTap: () {
                    if (nodesMap.containsKey(key)) {
                      setState(() {
                        nodesMap.remove(key);
                        graph.removeNode(graph.getNodeUsingId(key));
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    key,
                    style: TextStyle(
                      color: nodesMap[key],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  AlertDialog displayAddNode() {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        MaterialButton(
          onPressed: () {
            if (nodeController.text != "" &&
                !nodesMap.containsKey(nodeController.text)) {
              setState(() {
                nodesMap.putIfAbsent(nodeController.text, () => nodeColor);
                graph.addNode(Node.Id(nodeController.text));
                firstNode = nodeController.text;
                secondNode = nodeController.text;
              });
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add,
                size: 20,
                color: Colors.red,
              ),
              Text(
                "ADD",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
      backgroundColor: Colors.black,
      title: const Text(
        "ADD NODES",
        style: TextStyle(
          color: Colors.green,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 3,
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          const SizedBox(
            height: 3,
          ),
          TextField(
            autofocus: true,
            controller: nodeController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              hintText: "Node's Value",
              hintStyle: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlockPicker(
              pickerColor: Colors.white,
              onColorChanged: (Color color) {
                nodeColor = color;
              }),
        ],
      ),
    );
  }

  Widget displayNodeData({required String id}) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.done,
                size: 20,
                color: Colors.red,
              ),
              Text(
                "OK",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
      content: id.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "NUMBER OF NODES",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      graph.nodeCount().toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "PREDCESSORS\t",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        graph
                            .predecessorsOf(graph.getNodeUsingId(id))
                            .map((e) => e.key!.value)
                            .toList()
                            .toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "NODE DATA\t",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        graph.getNodeUsingId(id).key!.value,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "PREDCESSORS\t",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        graph
                            .predecessorsOf(graph.getNodeUsingId(id))
                            .map((e) => e.key!.value)
                            .toList()
                            .toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget displaySettings() {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 139, 134, 134),
      actions: [
        MaterialButton(
            child: const Icon(
              Icons.done,
              size: 30,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  "GRAPH OPTIONS",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            MaterialButton(
              child: const Text(
                "Add Node",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => displayAddNode(),
                );
              },
            ),
            MaterialButton(
              child: const Text(
                "Remove node",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => displayRemoveNode(),
                );
              },
            ),
            MaterialButton(
              child: const Text(
                "Add Edge",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => displayAddEdge(),
                );
              },
            ),
            MaterialButton(
              child: const Text(
                "Remove Edge",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget displayGrapher() {
    return GraphView(
        graph: graph,
        algorithm: algorithm,
        builder: (Node node) {
          return displayNode(
              data: node.key!.value, color: nodesMap[node.key!.value]!);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        children: [
          MaterialButton(
            child: const Icon(
              Icons.data_array,
              color: Colors.green,
              size: 30,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => displayNodeData(id: nodeId),
            ),
          ),
          MaterialButton(
            child: const Icon(
              Icons.settings,
              color: Colors.green,
              size: 30,
            ),
            onPressed: () => showDialog(
                context: context, builder: (context) => displaySettings()),
          ),
        ],
      ),
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: InteractiveViewer(
        child: displayGrapher(),
      ),
    );
  }
}
