package com.david.disshappserver.service;

import com.david.disshappserver.beans.Joke; /**
 * @Author ：程序员小冰
 * @新浪微博 ：http://weibo.com/mcxiaobing
 * @GitHub: https://github.com/QQ986945193
 */
public interface IJokeImgService {
    Integer addJokeImg(Joke joke);

    Joke findJokeImgById(int jokeImgId);

    void update(Joke joke);
}
