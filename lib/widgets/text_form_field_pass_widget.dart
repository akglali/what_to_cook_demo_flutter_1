import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextFormFieldPassWidget extends HookWidget {
  const TextFormFieldPassWidget({
    super.key,
    required this.usernameController,
    required this.label,
    this.validator,
    this.prefixIcon,
  });

  final TextEditingController usernameController;

  final String label;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    //getting the size of height and weight
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    //it will check whether text form field has focus or not.
    final focusState = useState<bool>(false);
    // it will hide and show the password
    final showPassState = useState<bool>(true);
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.02,
          right: screenWidth * 0.02,
          bottom: screenHeight * 0.03),
      child: FocusScope(
        child: Focus(
          onFocusChange: (focus) {
            focusState.value = focus;
          },
          child: TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            validator: validator,
            controller: usernameController,
            obscureText: showPassState.value,
            decoration: InputDecoration(
              fillColor: Colors.blue,
              label: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              prefixIcon: InkWell(
                onTap: () {
                  //every click user will hide and show the password
                  showPassState.value = !showPassState.value;
                },
                child: Icon(
                  prefixIcon,
                  color: focusState.value
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).iconTheme.color,
                  size: screenHeight * 0.02 + screenWidth * 0.02,
                ),
              ),
              suffixIcon: Icon(
                showPassState.value ? Icons.visibility_off : Icons.visibility,
                size: screenHeight * 0.02 + screenWidth * 0.02,
                color: focusState.value
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
