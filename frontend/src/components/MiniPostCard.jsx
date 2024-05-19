import { useState } from "react";
import Image1 from "../assets/Rectangle 41.png";
import Image2 from "../assets/Rectangle 640.png";
import { useNavigate, useLocation } from "react-router-dom";


export default function MiniPostCard(params) {
    const navigate = useNavigate();
    const { pathname } = useLocation();

    const [anchorEl, setAnchorEl] = useState(null);

    const open = Boolean(anchorEl);
  
  
    const handleClose = () => {
      setAnchorEl(null);
    };
    const handleClick = (event) => {
      setAnchorEl(event.currentTarget);
    };
  
    return (
        <div className="mini-post-card"
        onClick={() => navigate("/post/99")}
        >
        <img className="mini-post-card__img" src={Image1} alt="" />
        <div className="mini-post-card__content">
          <div className="mini-post-card__content__title">
            <div>
              <div>0xFC9...fB999</div>
              <div>@saleem · 1h</div>
            </div>

          
          </div>
          <div className="mini-post-card__content__post">
            Hello guys, Welcome to Chainsphere!
            <img
              className="mini-post-card__content__post__img pointer"
              src={Image2}
              alt=""
              // onClick={() => setImageModal(true)}
            />
          </div>
          <div className="mini-post-card__content__actions">
            <div className="mini-post-card__content__actions__comment">
              <svg
                viewBox="0 0 32 32"
                version="1.1"
                xmlns="http://www.w3.org/2000/svg"
                xmlnsXlink="http://www.w3.org/1999/xlink"
                xmlnsSketch="http://www.bohemiancoding.com/sketch/ns"
                fill="#000000"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g
                  id="SVGRepo_tracerCarrier"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                ></g>
                <g id="SVGRepo_iconCarrier">
                  {" "}
                  <title>comment-1</title>{" "}
                  <desc>Created with Sketch Beta.</desc> <defs> </defs>{" "}
                  <g
                    id="Page-1"
                    stroke="none"
                    stroke-width="1"
                    fill="none"
                    fill-rule="evenodd"
                    sketchType="MSPage"
                  >
                    {" "}
                    <g
                      id="Icon-Set"
                      sketchType="MSLayerGroup"
                      transform="translate(-100.000000, -255.000000)"
                      fill="#FFF"
                    >
                      {" "}
                      <path
                        d="M116,281 C114.832,281 113.704,280.864 112.62,280.633 L107.912,283.463 L107.975,278.824 C104.366,276.654 102,273.066 102,269 C102,262.373 108.268,257 116,257 C123.732,257 130,262.373 130,269 C130,275.628 123.732,281 116,281 L116,281 Z M116,255 C107.164,255 100,261.269 100,269 C100,273.419 102.345,277.354 106,279.919 L106,287 L113.009,282.747 C113.979,282.907 114.977,283 116,283 C124.836,283 132,276.732 132,269 C132,261.269 124.836,255 116,255 L116,255 Z"
                        id="comment-1"
                        sketchType="MSShapeGroup"
                      >
                        {" "}
                      </path>{" "}
                    </g>{" "}
                  </g>{" "}
                </g>
              </svg>
              20
            </div>
            <div className="mini-post-card__content__actions__like">
              <svg
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M18.0701 10.3199C17.8801 10.3199 17.6901 10.2499 17.5401 10.0999L12.0001 4.55994L6.46012 10.0999C6.17012 10.3899 5.69012 10.3899 5.40012 10.0999C5.11012 9.80994 5.11012 9.32994 5.40012 9.03994L11.4701 2.96994C11.7601 2.67994 12.2401 2.67994 12.5301 2.96994L18.6001 9.03994C18.8901 9.32994 18.8901 9.80994 18.6001 10.0999C18.4601 10.2499 18.2601 10.3199 18.0701 10.3199Z"
                  fill="#FFF"
                />
                <path
                  d="M12 21.2499C11.59 21.2499 11.25 20.9099 11.25 20.4999V3.66992C11.25 3.25992 11.59 2.91992 12 2.91992C12.41 2.91992 12.75 3.25992 12.75 3.66992V20.4999C12.75 20.9099 12.41 21.2499 12 21.2499Z"
                  fill="#FFF"
                />
              </svg>
              16
            </div>
            <div className="mini-post-card__content__actions__like">
              <svg
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M12.0001 21.2501C11.8101 21.2501 11.6201 21.1801 11.4701 21.0301L5.40012 14.9601C5.11012 14.6701 5.11012 14.1901 5.40012 13.9001C5.69012 13.6101 6.17012 13.6101 6.46012 13.9001L12.0001 19.4401L17.5401 13.9001C17.8301 13.6101 18.3101 13.6101 18.6001 13.9001C18.8901 14.1901 18.8901 14.6701 18.6001 14.9601L12.5301 21.0301C12.3801 21.1801 12.1901 21.2501 12.0001 21.2501Z"
                  fill="#FFF"
                />
                <path
                  d="M12 21.08C11.59 21.08 11.25 20.74 11.25 20.33V3.5C11.25 3.09 11.59 2.75 12 2.75C12.41 2.75 12.75 3.09 12.75 3.5V20.33C12.75 20.74 12.41 21.08 12 21.08Z"
                  fill="#FFF"
                />
              </svg>
              16
            </div>
            <div className="mini-post-card__content__actions__share">
              <svg
                viewBox="0 -0.5 25 25"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g
                  id="SVGRepo_tracerCarrier"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                ></g>
                <g id="SVGRepo_iconCarrier">
                  {" "}
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M14.734 15.8974L19.22 12.1374C19.3971 11.9927 19.4998 11.7761 19.4998 11.5474C19.4998 11.3187 19.3971 11.1022 19.22 10.9574L14.734 7.19743C14.4947 6.9929 14.1598 6.94275 13.8711 7.06826C13.5824 7.19377 13.3906 7.47295 13.377 7.78743V9.27043C7.079 8.17943 5.5 13.8154 5.5 16.9974C6.961 14.5734 10.747 10.1794 13.377 13.8154V15.3024C13.3888 15.6178 13.5799 15.8987 13.8689 16.0254C14.158 16.1521 14.494 16.1024 14.734 15.8974Z"
                    stroke="#FFF"
                    stroke-width="1"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  ></path>{" "}
                </g>
              </svg>
              24
            </div>
          </div>
          {pathname.includes("post") && (
            <form className="mini-post-card__content__form">
              <img src={Image1} alt="" />
              <input type="text" placeholder="Write a comment" />
            </form>
          )}
          {pathname.includes("post") && (
            <div className="mini-post-card__content__comments">
              <div className="mini-post-card__content__comments__card">
                <img
                  className="mini-post-card__content__comments__card__img"
                  src={Image1}
                  alt=""
                />
                <div className="mini-post-card__content__comments__card__content">
                  <div className="mini-post-card__content__comments__card__content__title">
                    <div>
                      <div>Saleem Jibril</div>
                      <div>@saleem · 1h</div>
                    </div>
                  </div>

                  <div className="mini-post-card__content__comments__card__content__post">
                    Comment from me
                  </div>
                </div>
              </div>
              <div className="mini-post-card__content__comments__card">
                <img
                  className="mini-post-card__content__comments__card__img"
                  src={Image1}
                  alt=""
                />
                <div className="mini-post-card__content__comments__card__content">
                  <div className="mini-post-card__content__comments__card__content__title">
                    <div>
                      <div>Saleem Jibril</div>
                      <div>@saleem · 1h</div>
                    </div>
                  </div>

                  <div className="mini-post-card__content__comments__card__content__post">
                    Comment from me
                  </div>
                </div>
              </div>
              <div className="mini-post-card__content__comments__card">
                <img
                  className="mini-post-card__content__comments__card__img"
                  src={Image1}
                  alt=""
                />
                <div className="mini-post-card__content__comments__card__content">
                  <div className="mini-post-card__content__comments__card__content__title">
                    <div>
                      <div>Saleem Jibril</div>
                      <div>@saleem · 1h</div>
                    </div>
                  </div>

                  <div className="mini-post-card__content__comments__card__content__post">
                    Comment from me
                  </div>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    )
}