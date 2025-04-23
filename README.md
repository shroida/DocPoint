# 🏥 DocPoint - Medical Appointment App

## 🌟 Overview
DocPoint is a user-friendly medical appointment application designed to streamline the booking process for patients while providing doctors with efficient appointment management tools.

## 📋 Table of Contents
1. [🚀 User Flow](#-user-flow)
2. [✨ Features](#-features)
3. [📱 Screens](#-screens)
4. [🎨 Design Specifications](#-design-specifications)
5. [🔔 Status Indicators](#-status-indicators)

---

## 🚀 User Flow

### 🔐 Authentication Flow
```mermaid
graph TD
    A[📲 Onboarding Screen] --> B{🔒 Logged In?}
    B -->|No| C[👤 Login/Signup]
    B -->|Yes| D{👨⚕️ User Type?}
    D -->|Patient| E[💙 Patient Home]
    D -->|Doctor| F[💚 Doctor Home]

![user flow docpoint](https://github.com/user-attachments/assets/0775614d-a26e-4b55-8c3f-bf8076f66cf1)


## Features
### Patient Features
- Browse available doctors with profiles

- Book appointments with date/time selection

- Track appointment status (Pending/Accepted/Cancelled)

- Secure payment integration

- In-app messaging with doctors

- Personal profile management

### Doctor Features
- View and manage appointment requests

- Accept/decline/pending appointment status

- Set consultation fees

- Patient communication via chat

- Professional profile management

## Screens
### Patient Screens (Blue Theme)
#### Home Screen

Doctor listings with:

Profile images

Names and specialties

"Book Appointment" buttons

Appointment Booking

Date/time picker

Reason for visit field

Confirmation screen

Appointment Status

Visual indicators for:

✅ Accepted → Proceed to payment

⏳ Pending → Waiting for confirmation

❌ Cancelled → Rebooking option

Payment Screen

Secure card entry

Payment confirmation

Profile Screen

Personal information

Medical history

Chat Screen

Messaging interface
