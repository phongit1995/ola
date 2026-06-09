.class Lchat/ola/vn/u/i;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/a;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/u/e;Ljava/util/List;)Lchat/ola/vn/w/cg;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/u/e;",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;)",
            "Lchat/ola/vn/w/cg;"
        }
    .end annotation

    new-instance p2, Lchat/ola/vn/w/cg;

    iget-short v0, p1, Lchat/ola/vn/u/e;->j:S

    invoke-direct {p2, v0}, Lchat/ola/vn/w/cg;-><init>(S)V

    iget-object v0, p1, Lchat/ola/vn/u/e;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0xa

    iget-object v1, p1, Lchat/ola/vn/u/e;->e:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    const/4 v0, 0x1

    iget v1, p1, Lchat/ola/vn/u/e;->g:I

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SI)V

    const/4 v0, 0x2

    iget v1, p1, Lchat/ola/vn/u/e;->h:I

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SI)V

    iget-object v0, p1, Lchat/ola/vn/u/e;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x3

    iget-object v1, p1, Lchat/ola/vn/u/e;->a:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object v0, p1, Lchat/ola/vn/u/e;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x4

    iget-object v1, p1, Lchat/ola/vn/u/e;->b:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-object v0, p1, Lchat/ola/vn/u/e;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    const/16 v0, 0x9

    iget-object v1, p1, Lchat/ola/vn/u/e;->d:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    const/16 v0, 0xf

    iget-byte v1, p1, Lchat/ola/vn/u/e;->k:B

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object v0, p1, Lchat/ola/vn/u/e;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    const/16 v0, 0x10

    iget-object p1, p1, Lchat/ola/vn/u/e;->f:Ljava/lang/String;

    invoke-virtual {p2, v0, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_4
    return-object p2
.end method

.method public a(Lchat/ola/vn/w/s;Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/w/s;",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x5

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/u/g;

    invoke-interface {v1}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1, v0, p1}, Lchat/ola/vn/u/g;->b(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    return-void
.end method
