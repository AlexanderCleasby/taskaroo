console.log('%c /home.js loaded..', 'font-size:20px; background:black; color: #FF69B4')

let owned_lists = []
let shared_lists = []

class List {
    constructor(id, title, completion) {
        this.id = id
        this.title = title
        this.completion = completion
    }
    render() {
        let li = document.createElement("li")
        let h3 = document.createElement("h3")
        let i = document.createElement("i")
        let a = document.createElement('a')

        h3.innerHTML = this.title
        a.innerHTML = "GO"
        a.href = `/lists/${this.id}`

        i.className = "fas fa-clipboard-list"
        a.className = "btn btn-outline-primary"

        li.append(h3)
        li.append(i)
        li.append(`${this.completion} tasks completed.`)
        li.append(document.createElement("br"))
        li.append(a)

        return li
    }
}

const populateList = (list, selector) => {
    ul = document.getElementById(selector)
    ul.innerHTML = list.length > 0 ? "" : "Nothing to see here."
    list.forEach((list) => ul.appendChild(list.render()))

}

const listsResponseDigest = (res, selector) => {
    if (selector == "owned") {
        owned_lists = res.map((list) => new List(list.id, list.title, list.completion))
        populateList(owned_lists, selector + "-lists")
    } else if (selector == "shared") {

    }
}

const renew = () => {
    fetch('/lists?selector=owned')
        .then(res => res.json())
        .then(res => res ? listsResponseDigest(res, "owned") : console.log('no owned lists found'))

    fetch('/lists?selector=shared')
        .then(res => res.json())
        .then(res => res ? listsResponseDigest(res, "shared") : console.log('no shared lists found'))
}

document.addEventListener("turbolinks:load", () => {
    if (document.getElementsByClassName("listIndex").length) {
        renew()
    }
})