import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextFormFieldWidget extends HookWidget {
  const TextFormFieldWidget({
    super.key,
    required this.usernameController,
    required this.label,
    this.validator,
    this.icon,
  });

  final TextEditingController usernameController;
  final String label;
  final String? Function(String?)? validator;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    //getting the size of height and weight
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

//it will check whether text form field has focus or not.
    final focusProvider = useState<bool>(false);
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.02,
          right: screenWidth * 0.02,
          bottom: screenHeight * 0.03),
      child: FocusScope(
        child: Focus(
          onFocusChange: (focus) {
            focusProvider.value = focus;
          },
          child: TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            validator: validator,
            controller: usernameController,
            decoration: InputDecoration(
              fillColor: Colors.blue,
              label: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              prefixIcon: Icon(
                icon,
                color: focusProvider.value
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).iconTheme.color,
                size: screenHeight * 0.02 + screenWidth * 0.02,
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
