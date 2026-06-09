.class Lchat/ola/vn/note/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/note/a;->b()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/note/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/note/a;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    iput-object p2, p0, Lchat/ola/vn/note/a$1;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {v0}, Lchat/ola/vn/note/a;->g(Lchat/ola/vn/note/a;)I

    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 8

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    int-to-long v1, p1

    int-to-long v3, p2

    iget-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->b(Lchat/ola/vn/note/a;)I

    move-result v5

    iget-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->c(Lchat/ola/vn/note/a;)I

    move-result v6

    iget-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->d(Lchat/ola/vn/note/a;)I

    move-result v7

    invoke-static/range {v0 .. v7}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;JJIII)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {v0}, Lchat/ola/vn/note/a;->a(Lchat/ola/vn/note/a;)I

    iget-object v0, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    iget-object v1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    iget-object v1, v1, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/note/a$1;->a:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "##"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#"

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, v2, p1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->b(Lchat/ola/vn/note/a;)I

    move-result p1

    if-lez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->c(Lchat/ola/vn/note/a;)I

    move-result p1

    iget-object v0, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {v0}, Lchat/ola/vn/note/a;->b(Lchat/ola/vn/note/a;)I

    move-result v0

    add-int/2addr p1, v0

    iget-object v0, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {v0}, Lchat/ola/vn/note/a;->d(Lchat/ola/vn/note/a;)I

    move-result v0

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->e(Lchat/ola/vn/note/a;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->c(Lchat/ola/vn/note/a;)I

    move-result p1

    iget-object v0, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {v0}, Lchat/ola/vn/note/a;->d(Lchat/ola/vn/note/a;)I

    move-result v0

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/note/a$1;->b:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->f(Lchat/ola/vn/note/a;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/note/a$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/note/a$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/note/a$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/note/a$1;->a()V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/note/a$1;->a()V

    return-void
.end method
