.class Lchat/ola/vn/m/v$13;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/v;->a(JJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:Lchat/ola/vn/m/v;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/v;J)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    iput-wide p2, p0, Lchat/ola/vn/m/v$13;->a:J

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/4 v0, 0x6

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    iget-object p1, p1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/e;->d(Z)V

    iget-object p1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    iget-object p1, p1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/e;->b(Z)V

    iget-object p1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    invoke-virtual {p1}, Lchat/ola/vn/m/v;->v()V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 6

    const/4 v0, 0x1

    aget-object p1, p1, v0

    check-cast p1, Ljava/util/List;

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    iget-object v1, v1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1, v0}, Lchat/ola/vn/entity/e;->d(Z)V

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    iget-wide v1, p0, Lchat/ola/vn/m/v$13;->a:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-nez v5, :cond_1

    iget-object v1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    iget-object v1, v1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1, p1}, Lchat/ola/vn/entity/e;->a(Ljava/util/List;)V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    invoke-virtual {v1}, Lchat/ola/vn/m/v;->c()V

    iget-object v1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    iget-object v1, v1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1, p1}, Lchat/ola/vn/entity/e;->b(Ljava/util/List;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    iget-object p1, p1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->d(Z)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    iget-object p1, p1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->b(Z)V

    iget-object p1, p0, Lchat/ola/vn/m/v$13;->b:Lchat/ola/vn/m/v;

    invoke-virtual {p1}, Lchat/ola/vn/m/v;->v()V

    return-void
.end method
