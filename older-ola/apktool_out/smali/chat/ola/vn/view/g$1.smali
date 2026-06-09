.class Lchat/ola/vn/view/g$1;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/g;->b()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/g;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/g;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0xf

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Z)V

    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {p1}, Lchat/ola/vn/view/g;->f(Lchat/ola/vn/view/g;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    const/4 p3, 0x1

    invoke-static {p1, p3}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;I)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {p1, p2}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;Z)Z

    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Z)V

    array-length v0, p1

    const/4 v1, 0x1

    if-le v0, v1, :cond_8

    aget-object v0, p1, v1

    check-cast v0, Ljava/util/List;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {v2}, Lchat/ola/vn/view/g;->f(Lchat/ola/vn/view/g;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {p1, v1}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;I)V

    return-void

    :cond_1
    new-instance v2, Ljava/util/ArrayList;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    const/4 v4, 0x2

    if-eqz v3, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/i;

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    if-eq v5, v1, :cond_3

    iget-object v5, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {v5}, Lchat/ola/vn/view/g;->g(Lchat/ola/vn/view/g;)Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    if-ne v5, v4, :cond_2

    :cond_3
    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->f(Lchat/ola/vn/view/g;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->h(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/view/g$c;->a()V

    :cond_5
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->h(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object v0

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/g$c;->a(Ljava/util/List;)V

    :cond_6
    array-length v0, p1

    if-le v0, v4, :cond_7

    iget-object v0, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    aget-object p1, p1, v4

    check-cast p1, Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_1

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Ljava/lang/String;)Ljava/lang/String;

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    iget-object v0, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->f(Lchat/ola/vn/view/g;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    xor-int/2addr v0, v1

    invoke-static {p1, v0}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;Z)Z

    iget-object p1, p0, Lchat/ola/vn/view/g$1;->a:Lchat/ola/vn/view/g;

    invoke-static {p1}, Lchat/ola/vn/view/g;->h(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/g$c;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_8
    return-void
.end method
