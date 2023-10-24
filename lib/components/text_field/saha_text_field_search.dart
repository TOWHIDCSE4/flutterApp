import 'package:flutter/material.dart';

class SahaTextFieldSearch extends StatefulWidget {
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Function? onClose;
  final bool? enabled;
  final String? initText;
  final String? hintText;
  final TextEditingController? textEditingController;

  const SahaTextFieldSearch(
      {Key? key, this.enabled = true, this.onSubmitted, this.onChanged, this.onClose, this.initText, this.textEditingController, this.hintText})
      : super(key: key);

  @override
  _SahaTextFieldSearchState createState() => _SahaTextFieldSearchState();
}

class _SahaTextFieldSearchState extends State<SahaTextFieldSearch> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = widget.textEditingController ?? TextEditingController();
    textEditingController.text = widget.initText ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        enabled: widget.enabled!,
        autofocus: false,
        onChanged: (va) {
          if (widget.onChanged != null) {
            widget.onChanged!(va);
          }
        },
        onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.search,
        controller: textEditingController,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              textEditingController.clear();
              widget.onClose!();
            },
          ),
          hintText: widget.hintText ?? 'Nhập từ khóa ...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.only(left: 10),
        ),
      ),
    );
  }
}
