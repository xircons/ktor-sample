package com.example

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.Serializable

@Serializable
data class Task(
    val id: Int,
    val content: String,
    val isDone: Boolean
)

@Serializable
data class TaskRequest(
    val content: String,
    val isDone: Boolean
)

object TaskRepository {
    private val tasks = mutableListOf<Task>()
    private var nextId = 1

    fun getAll(): List<Task> = tasks.toList()

    fun getById(id: Int): Task? = tasks.find { it.id == id }

    fun add(request: TaskRequest): Task {
        val task = Task(id = nextId++, content = request.content, isDone = request.isDone)
        tasks.add(task)
        return task
    }

    fun update(id: Int, request: TaskRequest): Task? {
        val index = tasks.indexOfFirst { it.id == id }
        return if (index != -1) {
            val updated = Task(id, request.content, request.isDone)
            tasks[index] = updated
            updated
        } else null
    }

    fun delete(id: Int): Boolean {
        val index = tasks.indexOfFirst { it.id == id }
        return if (index != -1) {
            tasks.removeAt(index)
            true
        } else false
    }
}

fun Application.configureRouting() {
    routing {
        get("/") {
            call.respondText("Hello Wuttikan!")
        }
        
        // GET /tasks - Return all tasks
        get("/tasks") {
            call.respond(HttpStatusCode.OK, TaskRepository.getAll())
        }
        
        // GET /tasks/{id} - Find and return a single task by ID
        get("/tasks/{id}") {
            val id = call.parameters["id"]?.toIntOrNull()
            if (id == null) {
                call.respond(HttpStatusCode.BadRequest, "Invalid ID")
                return@get
            }
            
            val task = TaskRepository.getById(id)
            if (task != null) {
                call.respond(HttpStatusCode.OK, task)
            } else {
                call.respond(HttpStatusCode.NotFound, "Task not found")
            }
        }
        
        // POST /tasks - Create a new task
        post("/tasks") {
            val request = call.receive<TaskRequest>()
            val task = TaskRepository.add(request)
            call.respond(HttpStatusCode.Created, task)
        }
        
        // PUT /tasks/{id} - Update an existing task
        put("/tasks/{id}") {
            val id = call.parameters["id"]?.toIntOrNull()
            if (id == null) {
                call.respond(HttpStatusCode.BadRequest, "Invalid ID")
                return@put
            }
            
            val request = call.receive<TaskRequest>()
            val updated = TaskRepository.update(id, request)
            if (updated != null) {
                call.respond(HttpStatusCode.OK, updated)
            } else {
                call.respond(HttpStatusCode.NotFound, "Task not found")
            }
        }
        
        // DELETE /tasks/{id} - Delete a task
        delete("/tasks/{id}") {
            val id = call.parameters["id"]?.toIntOrNull()
            if (id == null) {
                call.respond(HttpStatusCode.BadRequest, "Invalid ID")
                return@delete
            }
            
            val deleted = TaskRepository.delete(id)
            if (deleted) {
                call.respond(HttpStatusCode.NoContent)
            } else {
                call.respond(HttpStatusCode.NotFound, "Task not found")
            }
        }
    }
}
