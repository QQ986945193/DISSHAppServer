package com.david.disshappserver.service.impl;

import com.david.disshappserver.beans.Joke;
import com.david.disshappserver.dao.IJokeImgDao;
import com.david.disshappserver.service.IJokeImgService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * @Author ：程序员小冰
 * @新浪微博 ：http://weibo.com/mcxiaobing
 * @GitHub: https://github.com/QQ986945193
 */
@Service(value = "jokeImgService")
@Transactional
/**
 * 搞笑图片
 */
public class JokeImgServiceImpl implements IJokeImgService {

    @Resource(name = "jokeImgDao")
    private IJokeImgDao jokeImgDao;
    @Override
    public Integer addJokeImg(Joke joke) {
        return jokeImgDao.addJokeImg(joke);
    }

    @Override
    public Joke findJokeImgById(int jokeImgId) {
        return jokeImgDao.findJokeImgById(jokeImgId);
    }

    @Override
    public void update(Joke joke) {
        jokeImgDao.updateJoke(joke);
    }
}
