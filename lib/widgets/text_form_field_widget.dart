import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextFormFieldWidget extends HookWidget {
  const TextFormFieldWidget(
      {super.key, required this.usernameController, required this.label});

  final TextEditingController usernameController;
  final String label;

  @override
  Widget build(BuildContext context) {
    final focusProvider = useState<bool>(false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FocusScope(
        child: Focus(
          onFocusChange: (focus) {
            focusProvider.value = focus;
          },
          child: TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              fillColor: Colors.blue,
              label: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              prefixIcon: Icon(
                Icons.person,
                color: focusProvider.value
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).iconTheme.color,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
