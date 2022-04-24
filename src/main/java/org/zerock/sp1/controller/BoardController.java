package org.zerock.sp1.controller;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.sp1.dto.BoardDTO;
import org.zerock.sp1.dto.ListDTO;
import org.zerock.sp1.dto.ListResponseDTO;
import org.zerock.sp1.dto.PageMaker;
import org.zerock.sp1.service.BoardService;
import java.util.List;

@Log4j2
@Controller
@RequestMapping("/board/")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService service;

    @GetMapping("/")
    public String basic(){
        return "redirect:/board/list";
    }

    @GetMapping("/list")
    public void list( ListDTO listDTO, Model model){
       log.info("board list...........");
       log.info(listDTO);
       log.info(listDTO.getSkip());

       ListResponseDTO<BoardDTO> responseDTO = service.getList(listDTO);

       model.addAttribute("dtoList", responseDTO.getDtoList());

       int total = responseDTO.getTotal();

       model.addAttribute("pageMaker", new PageMaker(listDTO.getPage(), total ));

    }

    @GetMapping("/register")
    public void registerGET(){

    }

    @PostMapping("/register")
    public String  registerPOST(BoardDTO boardDTO, RedirectAttributes rttr){ // title, contents, writer등 파라미터를 자동수집해줌

        log.info("-----------------------");
        log.info(boardDTO);

        service.register(boardDTO);

        rttr.addFlashAttribute("result", "registerd");
        return "redirect:/board/list";
    }

    @GetMapping("/read/{bno}")
    public String read(@PathVariable("bno") Integer bno, ListDTO listDTO, Model model){
        log.info("========================");
        log.info(bno);
        log.info(listDTO);

        model.addAttribute("dto", service.getOne(bno));
        return "/board/read";
    }

    @GetMapping("/modify/{bno}")
    public String modify(@PathVariable("bno") Integer bno, ListDTO listDTO, Model model){
        log.info("=======================");
        log.info(bno);
        log.info(listDTO);

        model.addAttribute("dto", service.getOne(bno));
        return "/board/modify";
    }

    @PostMapping("/remove/{bno}")
    public String removePost(@PathVariable("bno") Integer bno, RedirectAttributes rttr){
        log.info("------------------------");
        log.info("remove" + bno);
        service.remove(bno);
        log.info("------------------------");

        rttr.addFlashAttribute("result", "removed");
        return "redirect:/board/list";

    }

    @GetMapping("/remove/{bno}")
    public String getNotSupported(){
        return "redirect:/board/list";
    }

    @PostMapping("/modify/{bno}")
    public String modifyPost(@PathVariable("bno") Integer bno, BoardDTO boardDTO, ListDTO listDTO, RedirectAttributes rttr){
        log.info("------------------------");
        boardDTO.setBno(bno);
        log.info("modify" + bno);

        service.update(boardDTO);
        log.info("------------------------");

        rttr.addFlashAttribute("result", "modified");
        return "redirect:/board/read/" + bno + listDTO.getLink();

    }


}
