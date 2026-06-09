.class public Lchat/ola/vn/message/o;
.super Lchat/ola/vn/message/f;


# instance fields
.field protected a:Lchat/ola/vn/e/h;


# direct methods
.method public constructor <init>()V
    .locals 2

    const-string v0, "unstrusted.people"

    const/4 v1, 0x7

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    return-void
.end method


# virtual methods
.method public F()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/message/o;->c:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/message/o;->c:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/o;->c:Ljava/util/List;

    return-object v0
.end method

.method public Y()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/o;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public a()J
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/o;->c:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->a()J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/message/o;->a:Lchat/ola/vn/e/h;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/e/h;

    invoke-direct {v0}, Lchat/ola/vn/e/h;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/message/o;->a:Lchat/ola/vn/e/h;

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/message/o;->c:Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/message/o;->c:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/message/o;->a:Lchat/ola/vn/e/h;

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    return-void
.end method

.method public z()I
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/message/o;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->z()I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/2addr v0, v2

    goto :goto_0

    :catch_0
    :cond_0
    return v0
.end method
