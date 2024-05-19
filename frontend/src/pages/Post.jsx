import { useEffect, useRef, useState } from "react";
import Image1 from "../assets/Rectangle 41.png";
import Image2 from "../assets/Rectangle 640.png";
import Menu from "@mui/material/Menu";
import MenuItem from "@mui/material/MenuItem";
import { Box } from "@mui/material";
import PostCard from "../components/PostCard";
import Sidebar from "../components/Sidebar";
import { useParams } from "react-router-dom";
import { useLocation } from "react";
import Links from "../components/Links";

export default function Post() {
  const [tab, setTab] = useState("home");

//   const {pathname} = useLocation();

//   useEffect(() => {
// console.log('pathname', pathname);
//   }, [])

 
  return (
    // THings to add
    <div className="feed">
      <main className="feed__main">
      <Sidebar />
        <div className="feed__main__timeline">
          <div className="feed__main__timeline__cards">
            <PostCard />
          </div>
        </div>
        <Links />
       
      </main>
    </div>
  );
}
