.class Lcom/mg/ola/a/a/b/c$d;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/mg/ola/a/a/b/a$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "d"
.end annotation


# instance fields
.field private a:Lcom/mg/ola/a/a/b/c;

.field private b:Lcom/mg/ola/a/a/b/c$e;

.field private c:I


# direct methods
.method public constructor <init>(Lcom/mg/ola/a/a/b/c;Lcom/mg/ola/a/a/b/c$e;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/mg/ola/a/a/b/c$d;->a:Lcom/mg/ola/a/a/b/c;

    iput-object p2, p0, Lcom/mg/ola/a/a/b/c$d;->b:Lcom/mg/ola/a/a/b/c$e;

    iput p3, p0, Lcom/mg/ola/a/a/b/c$d;->c:I

    return-void
.end method

.method private e(Lcom/mg/ola/a/a/b/a;)V
    .locals 6

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$d;->a:Lcom/mg/ola/a/a/b/c;

    iget-boolean v0, v0, Lcom/mg/ola/a/a/b/c;->b:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c$d;->b:Lcom/mg/ola/a/a/b/c$e;

    iget-object v1, v1, Lcom/mg/ola/a/a/b/c$e;->c:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    iget-object v3, p0, Lcom/mg/ola/a/a/b/c$d;->b:Lcom/mg/ola/a/a/b/c$e;

    iget-object v3, v3, Lcom/mg/ola/a/a/b/c$e;->c:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/c$c;

    iget v4, v3, Lcom/mg/ola/a/a/b/c$c;->b:I

    iget v5, p0, Lcom/mg/ola/a/a/b/c$d;->c:I

    if-ne v4, v5, :cond_1

    iget-object v4, v3, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    iget-object v4, v4, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    if-ne v4, p1, :cond_1

    invoke-virtual {p1, p0}, Lcom/mg/ola/a/a/b/a;->b(Lcom/mg/ola/a/a/b/a$a;)V

    move-object v0, v3

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$d;->b:Lcom/mg/ola/a/a/b/c$e;

    iget-object p1, p1, Lcom/mg/ola/a/a/b/c$e;->c:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$d;->b:Lcom/mg/ola/a/a/b/c$e;

    iget-object p1, p1, Lcom/mg/ola/a/a/b/c$e;->c:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$d;->b:Lcom/mg/ola/a/a/b/c$e;

    iget-object p1, p1, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/b/a;->a()V

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$d;->a:Lcom/mg/ola/a/a/b/c;

    invoke-static {p1}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;

    move-result-object p1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$d;->b:Lcom/mg/ola/a/a/b/c$e;

    iget-object v0, v0, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_3
    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/a;)V
    .locals 2

    iget v0, p0, Lcom/mg/ola/a/a/b/c$d;->c:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/b/c$d;->e(Lcom/mg/ola/a/a/b/a;)V

    :cond_0
    return-void
.end method

.method public b(Lcom/mg/ola/a/a/b/a;)V
    .locals 0

    return-void
.end method

.method public c(Lcom/mg/ola/a/a/b/a;)V
    .locals 1

    iget v0, p0, Lcom/mg/ola/a/a/b/c$d;->c:I

    if-nez v0, :cond_0

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/b/c$d;->e(Lcom/mg/ola/a/a/b/a;)V

    :cond_0
    return-void
.end method

.method public d(Lcom/mg/ola/a/a/b/a;)V
    .locals 0

    return-void
.end method
