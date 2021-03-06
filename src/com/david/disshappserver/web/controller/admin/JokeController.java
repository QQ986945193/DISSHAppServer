package com.david.disshappserver.web.controller.admin;

/**
 * @Author ：程序员小冰
 * @新浪微博 ：http://weibo.com/mcxiaobing
 * @GitHub: https://github.com/QQ986945193
 */

import com.david.disshappserver.beans.Joke;
import com.david.disshappserver.beans.User;
import com.david.disshappserver.common.Limit;
import com.david.disshappserver.common.PageResult;
import com.david.disshappserver.common.constants.AdminConstant;
import com.david.disshappserver.service.IJokeService;
import com.david.disshappserver.service.IUserService;
import com.david.disshappserver.utils.LogUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * 笑话的controller
 */
@Controller
@RequestMapping("/admin")
public class JokeController {

    @Resource(name = "userService")
    private IUserService userService;

    @Resource(name = "jokeService")
    private IJokeService jokeService;

    /**
     * 笑话列表  分页显示。每页默认显示是0
     */
    @RequestMapping("/joke/list")
    public String list(Model model,
                       @RequestParam(value = "offset", required = false, defaultValue = "0") int offset,
                       @RequestParam(value = "count", required = false, defaultValue = "10") int count) {
        Limit limit = Limit.buildLimit(offset, count);
        PageResult<Joke> pageResult = jokeService.getJokes(limit, Joke.TYPE_JOKE_FUN, Joke.SORT_NEW);
        model.addAttribute("pageResult", pageResult);
        return "admin/jokeList";
    }


    /**
     * 进入添加笑话的jsp
     */
    @RequestMapping("/joke/addToJsp")
    public String addToJsp(HttpSession session, Model model) {
        User user = (User) session.getAttribute(AdminConstant.KEY_CURR_USER);
        if (user == null) {
            return "admin/login";
        }
        List<User> users = userService.findAllAdminUsers();
        model.addAttribute("users", users);
        return "admin/addJoke";
    }

    /**
     * 跳转到某一页
     */
    @RequestMapping("/joke/goPage")//vipName搜索的内容
    public String goPage(Model model,
                         @RequestParam(value = "pageCount", required = false, defaultValue = "0") int pageCount,
                         @RequestParam(value = "count", required = false, defaultValue = "10") int count,
                         @RequestParam(value = "vState") String vState,//是否可用
                         @RequestParam(value = "vipName") String vipName) {
        Limit limit = Limit.buildLimit(pageCount, count);
        PageResult<Joke> pageResult = null;
        if (StringUtils.isEmpty(vState)||vState.equals("不限")) {
            pageResult = jokeService.getJokesByLike(limit, Joke.TYPE_JOKE_FUN, Joke.SORT_NEW,Joke.NOT_DELETE);
        }
        if (vState.equals("可用")) {
            pageResult = jokeService.getJokesByLike(limit, Joke.TYPE_JOKE_FUN, Joke.SORT_NEW,Joke.NOT_DELETE);

        }
        if (vState.equals("删除")) {
            pageResult = jokeService.getJokesByLike(limit, Joke.TYPE_JOKE_FUN, Joke.SORT_NEW, Joke.DELETE);

        }
        LogUtils.i("pageResult"+pageResult.getList().size());
        model.addAttribute("pageResult", pageResult);
        return "admin/jokeList";
    }

    /**
     * 添加笑话的action
     * required 必须得
     */
    @RequestMapping("/joke/addJoke")
    public String addJoke(@RequestParam(required = true) String content,
                          @RequestParam(required = false) Integer isBest,
                          @RequestParam(required = true) Integer userId,
                          @RequestParam(required = false) Integer supportNum) {
        //通过用户ID的到用户
        User user = userService.findUserById(userId);
        if (user == null) {
            //如果没有此用户，则提示失败
            return "admin/error";

        }
        Joke joke = new Joke();

        joke.setUserId(user.getId());
        joke.setContent(content);
        joke.setUserNike(user.getUserNike());
        //用户头像
        joke.setPortraitUrl(user.getPortrait_url());
        if (isBest == null) {
            //默认是精选
            joke.setIsBest(Joke.BEST);
        }
        joke.setIsBest(isBest);
        //默认是启用
        joke.setIsPass(Joke.PASS);
        joke.setCreateDate(new Date());
        joke.setType(Joke.TYPE_JOKE_FUN);
        //插入数据库
        jokeService.addJoke(joke);
        return "admin/addSuccess";
    }
}
