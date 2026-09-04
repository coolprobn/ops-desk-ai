module ApplicationHelper
  def nav_link_to(name, path)
    active = current_page?(path)
    classes = [
      "block rounded-md px-3 py-2 text-sm font-medium transition-colors",
      (active ? "bg-zinc-800 text-zinc-50" : "text-zinc-400 hover:bg-zinc-900 hover:text-zinc-100")
    ].join(" ")

    link_to name, path, class: classes
  end
end
