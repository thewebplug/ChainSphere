import { useEffect, useRef, useState } from "react";
import PostCard from "../components/PostCard";
import Links from "../components/Links";
import Sidebar from "../components/Sidebar";
import { useLocation } from "react-router-dom";
import MiniPostCard from "../components/MiniPostCard";

export default function Feed() {
  const [tab, setTab] = useState("home");
  const { pathname } = useLocation();

  useEffect(() => {
    if (pathname.includes("trending")) {
      setTab("trending");
    }
  }, [pathname]);

  return (
    // THings to add
    <div className="feed">
      <main className="feed__main">
        <Sidebar />
        <div className="feed__main__timeline">
          <div className="feed__main__timeline__nav">
            <h1
              className={tab === "home" && "feed__main__timeline__nav__active"}
              onClick={() => setTab("home")}
            >
              Home
            </h1>
            <h1
              className={
                tab === "trending" && "feed__main__timeline__nav__active"
              }
              onClick={() => setTab("trending")}
            >
              Trending
            </h1>
            <h1
              className={
                tab === "rewards" && "feed__main__timeline__nav__active"
              }
              onClick={() => setTab("rewards")}
            >
              Rewards
            </h1>
          </div>
          {tab === "home" && (
            <div className="feed__main__timeline__cards">
              <PostCard />
              <PostCard />
              <PostCard />
              <PostCard />
            </div>
          )}

          {tab === "trending" && (
            <div className="feed__main__timeline__cards">
              <PostCard />
              <PostCard />
              <PostCard />
              <PostCard />
            </div>
          )}
<div className="feed__main__timeline__winners">
<div className="feed__main__timeline__winners__current-winners">
            <div className="feed__main__timeline__winners__current-winners__title">This week's winners</div>
            <div className="feed__main__timeline__winners__current-winners__inner">
            <div className="feed__main__timeline__winners__current-winners__inner__item">
              <div className="feed__main__timeline__winners__current-winners__inner__item__title">
                1
              </div>
              <MiniPostCard />
            </div>
            <div className="feed__main__timeline__winners__current-winners__inner__item">
              <div className="feed__main__timeline__winners__current-winners__inner__item__title">
                2
              </div>
              <MiniPostCard />
            </div>
            <div className="feed__main__timeline__winners__current-winners__inner__item">
              <div className="feed__main__timeline__winners__current-winners__inner__item__title">
                3
              </div>
              <MiniPostCard />
            </div>
            </div>
            
          </div>
          <div className="feed__main__timeline__winners__current-winners feed__main__timeline__winners__past-winners">
            <div className="feed__main__timeline__winners__current-winners__title">Past winners</div>
            <div className="feed__main__timeline__winners__current-winners__inner">
            <div className="feed__main__timeline__winners__current-winners__inner__item">
              
              <MiniPostCard />
            </div>
            <div className="feed__main__timeline__winners__current-winners__inner__item">
              
              <MiniPostCard />
            </div>
            <div className="feed__main__timeline__winners__current-winners__inner__item">
              
              <MiniPostCard />
            </div>
            </div>
            
          </div>
</div>
          
        </div>

        <Links />
      </main>
    </div>
  );
}
