# Movie Ticketing System

A Ruby on Rails application for managing movie bookings and ticket purchases for a multiplex chain.

Team RUBYISTS:

1. Aditya Singh (asingh78)
2. Shivang Nitinkumar Patel (spatel74)
3. Vedant Patel (vpatel32)

[![Watch the video](https://img.youtube.com/vi/YOUTUBE_VIDEO_ID/maxresdefault.jpg)](https://drive.google.com/file/d/1W84843EC58ScbxCDfLTqoqf3_ubi9fcw/view)


## Admin Credentials
email: "shiv@movie.com"

password: "shiv987654"

## Installation
```bash
git clone https://github.ncsu.edu/vpatel32/Rubyists_Program2.git
cd Rubyists_Program2
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server
```

## Features Navigation Guide

### For Users
- **Sign Up**: Click "Sign Up" on the homepage to create a new account
- **View Movies**: Click "Browse Movies" on the user dashboard to see all available movies
- **Book Tickets**: 
  1. Click on a movie from the movie list
  2. Select a show time
  3. Choose number of seats
  4. Click "Purchase Tickets" to complete booking
- **View Bookings**: Click "My Bookings" in the user dashboard to see booking history
- **Cancel Tickets**: 
  1. Go to "My Bookings"
  2. Find the booking
  3. Click "Cancel Ticket" button
- **Edit Profile**: Click "My Profile" in the navigation menu, then "Edit Profile"

### For Admin
- **Manage Movies**:
  1. Go to "Movie Management" in admin dashboard
  2. Use "Add Movie" button to create new movies
  3. Use Edit/Delete buttons next to each movie entry
- **Manage Shows**:
  1. Go to "Show Management"
  2. Click "Create New Show" to add shows
  3. Use Edit/Delete buttons for existing shows
- **View Users**: Click "User Management" to see all registered users
- **View Tickets**: Click "Ticket Management" to see all bookings

## Testing Instructions

### User Features
1. **Creating an Account**:
   - Go to homepage
   - Click "Sign Up"
   - Fill in: Name, Email, Password, Phone, Address
   - Test with invalid email to verify validation

2. **Booking a Ticket**:
   - Log in with test account
   - Select any movie from the list
   - Choose an available show
   - Select 2 seats
   - Complete payment
   - Verify booking in "My Bookings"

3. **Canceling a Ticket**:
   - Go to "My Bookings"
   - Select any active booking
   - Click "Cancel Ticket"
   - Verify seat count is updated in show details

### Admin Features
1. **Adding a Movie**:
   - Log in as admin
   - Go to "Movie Management"
   - Click "Add Movie"
   - Fill required fields: Title, Genre, Duration, Language, Rating, Release Date
   - Verify movie appears in the list

2. **Creating a Show**:
   - Go to "Show Management"
   - Click "Create New Show"
   - Select movie, date, time, seats, price
   - Verify show appears in movie details

## Note
- The system validates all inputs including email format, phone numbers, and password requirements
- Negative values are not accepted for prices or seat counts
- Past dates cannot be selected for new shows
- Credit card information is required but not validated (test mode)

## Development Setup
1. Ruby version: 3.4.1 or higher
2. Rails version: 8.0.1 or higher
3. Database: SQLite3
