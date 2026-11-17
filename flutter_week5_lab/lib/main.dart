import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuScreen(),
    );
  }
}
 
// -------------------------------------------------------------------------
// SCREEN 1 - Menu
// -------------------------------------------------------------------------
 
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
 
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Stores the completed pizza order.
  String currentOrder = '';
  int cartItems = 0;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle pizzaButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      minimumSize: const Size(220, 50),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Shop 🍕'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose Your Pizza',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                
              children: [
          
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.blue,
                  size: 40,
                ),

                const SizedBox(width: 10),
              
                Text(
                  '$cartItems ${cartItems == 1 ? "Item" : "Items"}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

        const SizedBox(height: 20),

            /*
            Text(
              currentOrder.isEmpty ? 'Cart is Empty' : currentOrder,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            */

// --------------------------------------------------------------------
// Pizza button - Margherita
// ------------------------------------------------------------------

             ElevatedButton(
              style: pizzaButtonStyle,
              onPressed: () async {
                final order = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomizeScreen(
                      pizzaName: 'Margherita',
                    ),
                  ),
                );

                 if (order != null) {
                  setState(() {
                    currentOrder = order;
                    cartItems++;
                  });
                }
              },

              child: const Text('🍕 Margherita'),
            ),

            const SizedBox(height: 20),

// --------------------------------------------------------------------
// Pizza button - Pepperoni
// ------------------------------------------------------------------

            ElevatedButton(
              style: pizzaButtonStyle,
              onPressed: () async {
                final order = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomizeScreen(
                      pizzaName: 'Pepperoni',
                    ),
                  ),
                );

                if (order != null) {
                  setState(() {
                    currentOrder = order;
                    cartItems++;
                  });
                }
              },

              child: const Text('🍕 Pepperoni'),
            ),

            const SizedBox(height: 20),

// --------------------------------------------------------------------
// Pizza button - Veggie
// ------------------------------------------------------------------

            ElevatedButton(
              style: pizzaButtonStyle,
              onPressed: () async {
                final order = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomizeScreen(
                      pizzaName: 'Veggie',
                    ),
                  ),
                );

                if (order != null) {
                  setState(() {
                    currentOrder = order;
                    cartItems++;
                  });
                }
              },
              child: const Text('🍕 Veggie'),
            ),

            const SizedBox(height: 30),


//--------------------------------------------------------
// Cart Screen
//---------------------------------------------------------

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      order: currentOrder,
                    ),
                  ),
                );
              },
              child: const Text('View Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// SCREEN 2 - Customize
// -------------------------------------------------------------------------

class CustomizeScreen extends StatefulWidget {
  final String pizzaName;
 
  const CustomizeScreen({
    super.key,
    required this.pizzaName,
  });

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

 class _CustomizeScreenState extends State<CustomizeScreen> {
  String selectedSize = 'Medium';
  String selectedCrust = 'Thin Crust';

  List<String> selectedToppings = [];

  Widget buildToppingChip(String topping) {
    return SizedBox(
      width: 120,
      child: ChoiceChip(
        label: Center(
          child: Text(topping),
        ),
        selected: selectedToppings.contains(topping),
        onSelected: (selected) {
          setState(() {
            if (selected) {
              selectedToppings.add(topping);
            } else {
              selectedToppings.remove(topping);
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Pizza'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.pizzaName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Choose Size',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Row(
              children: [
                Radio<String>(
                  value: 'Small',
                  groupValue: selectedSize,
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value!;
                    });
                  },
                ),
                const Text('Small'),

                Radio<String>(
                  value: 'Medium',

                  groupValue: selectedSize,
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value!;
                    });
                  },
                ),
                const Text('Medium'),

                Radio<String>(
                  value: 'Large',
                  groupValue: selectedSize,
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value!;
                    });
                  },
                ),
                const Text('Large'),
              ],
            ),

            const SizedBox(height: 10),

             const Text(
              'Choose Crust',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Thin Crust'),
              value: 'Thin Crust',
              groupValue: selectedCrust,
              onChanged: (value) {
                setState(() {
                  selectedCrust = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Thick Crust'),
              value: 'Thick Crust',
              groupValue: selectedCrust,
              onChanged: (value) {
                setState(() {
                  selectedCrust = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Cheese Stuffed Crust'),
              value: 'Cheese Stuffed Crust',
              groupValue: selectedCrust,
              onChanged: (value) {
                setState(() {
                  selectedCrust = value!;
                });
              },
            ),

            const Text(
              'Choose Toppings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildToppingChip('Cheese'),
                buildToppingChip('Olives'),
                buildToppingChip('Mushrooms'),
                buildToppingChip('Peppers'),
                buildToppingChip('Pineapple'),
              ],
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String order =
                        '${widget.pizzaName}\n'
                        'Size: $selectedSize\n'
                        'Crust: $selectedCrust\n'
                        'Toppings: ${selectedToppings.join(", ")}';

                    Navigator.pop(
                      context,
                      order,
                    );
                  },
                  child: const Text('Add To Cart'),
                ),

                const SizedBox(width: 15),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// Screen 3 - Cart
// -------------------------------------------------------------------------

class CartScreen extends StatelessWidget {
  final String order;

   const CartScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                order.isEmpty
                    ? 'Cart is Empty'
                    : order,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConfirmationScreen(),
                    ),
                  );
                },

                child: const Text('Place Order'),
              ),
                

               const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// -------------------------------------------------------------------------
// Screen 4 - Confirmation
// -------------------------------------------------------------------------

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [

            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),

            const SizedBox(height: 20),

            const Text('Order Placed Successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text('Thank you for your order.',
            ),
          ],
        ),
      ),
    );
  }
}
//Git push
//git init
//git add .
//git commit -m "Initial commit"
//git remote add origin https://github.com/yourusername/yourrepo.git
//git branch -M main
//git push -u origin main