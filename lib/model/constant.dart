// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Constant {
  static const devMode = true;
  static const users = 'Users';
  static const USERPROFILE_COLLECTION = 'userProfile';
  static const USERFRIENDS_COLLECTION = 'UserFriends';
  static const WALLET_COLLECTION = 'VirtualWallet';
  static const TRANSACTION_COLLECTION = 'UserTransactions';
  static const DARKMODE = true;
  static const debts = 'Debts';
  static const budgets = 'budgets';
  static const accounts = 'accounts';
  static const months = 'months';
  static const categories = 'categories';
  static const purchases = 'Purchases';
  static const savings = "Savings";
  static const plans = 'Plans';
  static const savedTipCalc = 'SavedTipCalc';
  static const savedFuelCostCalc = 'SavedFuelCostCalc';
  static const budgetAmount = 'budgetAmount';
  static const subcatagory = 'subcatagory';
  static const savedVehicle = 'SavedVehicle';

  static const List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text('Mortgage'), value: 'Mortgage'),
    DropdownMenuItem(child: Text('Car loan'), value: 'Car loan'),
    DropdownMenuItem(child: Text('Credit Card'), value: 'Credit Card'),
    DropdownMenuItem(child: Text('Medical Bill'), value: 'Medical Bill'),
  ];
}

enum ArgKey {
  user,
  filename,
  debtList,
  purchaseList,
  savings,
  planList,
  onePhotoMemo,
  userProfile,
  replies,
  comments,
  profile,
  userList,
  currentUID,
  singleDebt,
  isFriendAdded,
  wallet,
  transactionList,
  transType,
  selected,
  request,
  requestList
}

enum Filter {
  MyFriends,
  AllUsers,
  FriendRequest,
}

enum SearchOption {
  email,
  name,
}

enum Transfer {
  Send,
  Request,
}

enum Tools {
  stateTaxDatabase,
  fedTaxDatabase,
}

List<DropdownMenuItem<String>> menuItems = [
  const DropdownMenuItem(child: Text('Mortgage'), value: 'Mortgage'),
  const DropdownMenuItem(child: Text('Car loan'), value: 'Car loan'),
  const DropdownMenuItem(child: Text('Credit Card'), value: 'Credit Card'),
  const DropdownMenuItem(child: Text('Medical Bill'), value: 'Medical Bill'),
];

List<DropdownMenuItem<String>> get dropdownItems {
  return menuItems;
}

// view mode for lists
enum ListMode { view, add, delete, edit }

enum BudgetListMode { view, add, delete, edit }

class ValidationError {
  static String requiredFieldError = 'Required';
  static String budgetTitleLengthError = 'Minimum 4 characters';
  static String titleLengthError = 'Title can not be empty';
  static String dateOutOfBoundsError = 'Date Due not valid';
  static String accountNumberLengthError =
      'Account number must be at least 8 digits';
  static String amountLengthError = 'Amount can not be empty';
  static String monthTooLongError = 'Must be 1 or 2 characters';
  static String monthValueError = 'Must be a valid number for a month';
  static String notANumberError = 'Must be a number';
  static String yearLengthError = 'Must be 4 characters';
  static String yearValueError = 'Must be a valid number for a year';
  static String yearRangeError = 'Really? You a budget THAT year?';
  static String invalidEmailLengthError = 'Email must be at least 8 characters';
  static String invalidEmailFormatError = 'Invalid Email Address';
  static String accountRateError = 'Rate must be at least 1 digit';
  static String accountRateNANError = 'Rate must be a number';
  static String websiteLengthError = 'Website must be at least 5 characters';
  static String websiteFormatError = 'Not a valid website';
}
