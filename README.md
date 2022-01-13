
# Store-Food-app

## Description
Store-Food-app: An application that allows productive families to display and sell their products, in addition to donating them. In this app, the manager can add productive families's products in the app. In the other hand, the customer can view and order those products. 

## Customer Stories/Manager:
- Register: As a user ,I want register in application  as a Customer or Manager so that I can access to the app.
- Login: As a user , I want to login so that I can use the application.
 
 
## Manager stories 
Manager: As a manager  I can Add the (Categories,products), familes proudctive ,price ,and  add the proudct either in sale or donate page.
Manager: As manager  I can Update or Delete  the (Categories,products), familes proudctive ,price ,and  add the proudct either in sale or donate page.

## Customer stories 
 - AS customer I can show the categries .
 - As customer I can show the Prouct, Price, Cooked by which families.
 - As customer I can add/delete the Product in the cart.
 - AS customer I can add prouct  on favorite/rate . 
 - As customer I can Show donate Product .
 - AS customer I can communicate with the Customer Services.
 
 
 
 | Component         | Permissions | Behavuior 
| :---              |     ---      |   :---    |
| WelcomScreen      | public       | Frist page |
| SignupScreen      |  public      | link to register as customer, Manager signup.|
| login Page        | public       | link to login, navigate to TabBar after longIn.|
| ShowStorePage     |customer/Manger| Show all Categories, proudct for custmer ,Manager can add category and prouct. Also, Manager can add the proudct for donate or sales |
| Cart page         |Customer only|Buy the proudct and display the alert how much the time needed to finalize the order.|
|donate page        |customer/Manger|the products added by the Manager and diplayed by the customer|
| SettingPage       |customer/Manger | Change the profile page,display how many orders on the app, Change the app language , change apperance(dark/light) and communicate to Customer Service.

## Components:
*  WelcomScreen. 
*  LoginScreen.
*  SignupScreen.
*  ProfileScreen.
*  StoreTabBarVC.
*  ShowStoreVC.
*  DonateVC.
*  CartVC.
*  AddCategoryVC.
*  DetialsVC.
*  AddProudctVC.
*  MenueVC.
*  CustomerSupportVC.

## Service
##### Auth Service
auth.login(user)
auth.signup(user)
auth.logout()

## Models
* Model 
* FireBaseOperation


## Slides
Repository link:
presentation link:https://github.com/kholodalabdulrhman7/StoreFood https://docs.google.com/presentation/d/1-xpfdDpJRMO0-aUczouSwL1cFzWgkms_BzwZgFn1MkI/edit?usp=sharing
