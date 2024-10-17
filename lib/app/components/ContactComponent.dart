import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/text.dart';

class ContactComponent extends StatefulWidget {
  final String nameContact;
  final String phoneContact;
  final VoidCallback onPresseDelete;
  final VoidCallback onPresseCall;

  const ContactComponent({
    Key? key,
    required this.nameContact,
    required this.onPresseDelete,
    required this.onPresseCall,
    required this.phoneContact,
  }) : super(key: key);

  @override
  State<ContactComponent> createState() => _ContactComponentState();
}

class _ContactComponentState extends State<ContactComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: ColorData.colorNavBar,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align items to the top
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 0, top: 10, bottom: 10, left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(
                        "assets/images/sosicon.png",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        UtilText.truncateString(widget.nameContact, 10),
                        style: TextStyle(
                          color: ColorData.colorText,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.phoneContact,
                        style: TextStyle(
                          color: ColorData.colorText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.emergency_share,
                  color: ColorData.colorSos,
                  size: 28,
                ),
                onPressed: () {
                  widget.onPresseCall;
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.pending,
                  color: ColorData.colorIcon,
                  size: 28,
                ),
                onPressed: () {
                  widget.onPresseDelete;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
