.class Lchat/ola/vn/m/x$2;
.super Lchat/ola/vn/entry/c/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/x;->a_(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/x;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/x;Lchat/ola/vn/entity/t;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/x$2;->a:Lchat/ola/vn/m/x;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entry/c/d;-><init>(Lchat/ola/vn/entity/t;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/x$2;->a:Lchat/ola/vn/m/x;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/m/x;->a(Lchat/ola/vn/m/x;Z)Z

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/entry/c/d;->a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    aget-object v1, p1, v0

    check-cast v1, Lchat/ola/vn/entity/ad;

    invoke-virtual {v1}, Lchat/ola/vn/entity/ad;->m()S

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/m/x$2;->a:Lchat/ola/vn/m/x;

    invoke-static {v1, v0}, Lchat/ola/vn/m/x;->a(Lchat/ola/vn/m/x;Z)Z

    invoke-super {p0, p1}, Lchat/ola/vn/entry/c/d;->a([Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/m/x$2;->a:Lchat/ola/vn/m/x;

    invoke-static {p1}, Lchat/ola/vn/m/x;->b(Lchat/ola/vn/m/x;)Lchat/ola/vn/b/aj;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/aj;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
