import logo from "./logo.svg";
import Feed from "./pages/Feed";
import Home from "./pages/Home";
import {
  BrowserRouter as Router,
  Route,
  Routes,
} from "react-router-dom";
import Profile from "./pages/Profile";
import Signup from "./pages/Signup";
import Login from "./pages/Login";
import Post from "./pages/Post";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/login" element={<Login />} />
        <Route path="/feed" element={<Feed />} />
        <Route path="/feed/trending" element={<Feed />} />
        <Route path="/post/:id" element={<Post />} />
        <Route path="/profile" element={<Profile />} />
      </Routes>
    </Router>
  );
}

export default App;
