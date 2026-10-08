part of '../custom_widgets.dart';

class ComboConBusqueda extends StatefulWidget {
  final String title;
  final List<String> datos;
  final ValueChanged<String> complete;
  final String? selectValue;
  final String searchHint;

  const ComboConBusqueda({
    required this.datos,
    required this.complete,
    this.title = '',
    this.searchHint = 'Seleccione...',
    this.selectValue,
  });

  @override
  _ComboConBusquedaState createState() => _ComboConBusquedaState();
}

class _ComboConBusquedaState extends State<ComboConBusqueda> {
  final TextEditingController _controller = TextEditingController();
  List<String> _filteredItems = [];
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.datos;
    _selectedItem = widget.selectValue; // Inicializa con el valor preseleccionado
  }

  void _showDropdownDialog() {
    _controller.clear();
    _filteredItems = widget.datos;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(widget.title, overflow: TextOverflow.ellipsis),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller,
                      onChanged: (query) {
                        setStateDialog(() {
                          _filteredItems = widget.datos
                              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200, // Altura fija para el listado
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(_filteredItems[index]),
                                selected: _filteredItems[index] == _selectedItem,
                                selectedTileColor: Colors.blueAccent,
                                selectedColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    _selectedItem = _filteredItems[index];
                                  });
                                  Navigator.pop(context);
                                  widget.complete(_selectedItem!);
                                },
                              ),
                              Divider(height: 1, color: Colors.blueAccent),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showDropdownDialog,
      child: desing(Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.selectValue ?? _selectedItem ?? widget.searchHint,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
      )),
    );
  }

  Widget desing(Widget child) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 5),
              constraints: BoxConstraints(maxWidth: 100),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            widget.datos.isNotEmpty ? Flexible(child: child) : Container(),
          ],
        ),
      ),
    );
  }
}
