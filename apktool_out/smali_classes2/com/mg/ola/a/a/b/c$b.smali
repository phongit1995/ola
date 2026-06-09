.class public Lcom/mg/ola/a/a/b/c$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/a/a/b/c;

.field private b:Lcom/mg/ola/a/a/b/c$e;


# direct methods
.method constructor <init>(Lcom/mg/ola/a/a/b/c;Lcom/mg/ola/a/a/b/a;)V
    .locals 2

    iput-object p1, p0, Lcom/mg/ola/a/a/b/c$b;->a:Lcom/mg/ola/a/a/b/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/mg/ola/a/a/b/c;->b(Lcom/mg/ola/a/a/b/c;)Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/c$e;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c$b;->b:Lcom/mg/ola/a/a/b/c$e;

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$b;->b:Lcom/mg/ola/a/a/b/c$e;

    if-nez v0, :cond_0

    new-instance v0, Lcom/mg/ola/a/a/b/c$e;

    invoke-direct {v0, p2}, Lcom/mg/ola/a/a/b/c$e;-><init>(Lcom/mg/ola/a/a/b/a;)V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c$b;->b:Lcom/mg/ola/a/a/b/c$e;

    invoke-static {p1}, Lcom/mg/ola/a/a/b/c;->b(Lcom/mg/ola/a/a/b/c;)Ljava/util/HashMap;

    move-result-object v0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c$b;->b:Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {v0, p2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p1}, Lcom/mg/ola/a/a/b/c;->d(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;

    move-result-object p1

    iget-object p2, p0, Lcom/mg/ola/a/a/b/c$b;->b:Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$b;->a:Lcom/mg/ola/a/a/b/c;

    invoke-static {v0}, Lcom/mg/ola/a/a/b/c;->b(Lcom/mg/ola/a/a/b/c;)Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/c$e;

    if-nez v0, :cond_0

    new-instance v0, Lcom/mg/ola/a/a/b/c$e;

    invoke-direct {v0, p1}, Lcom/mg/ola/a/a/b/c$e;-><init>(Lcom/mg/ola/a/a/b/a;)V

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c$b;->a:Lcom/mg/ola/a/a/b/c;

    invoke-static {v1}, Lcom/mg/ola/a/a/b/c;->b(Lcom/mg/ola/a/a/b/c;)Ljava/util/HashMap;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$b;->a:Lcom/mg/ola/a/a/b/c;

    invoke-static {p1}, Lcom/mg/ola/a/a/b/c;->d(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    new-instance p1, Lcom/mg/ola/a/a/b/c$c;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c$b;->b:Lcom/mg/ola/a/a/b/c$e;

    const/4 v2, 0x0

    invoke-direct {p1, v1, v2}, Lcom/mg/ola/a/a/b/c$c;-><init>(Lcom/mg/ola/a/a/b/c$e;I)V

    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/b/c$e;->a(Lcom/mg/ola/a/a/b/c$c;)V

    return-object p0
.end method
