.class Lchat/ola/vn/entry/b/s$1;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/s;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/s;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/s;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/s$1;->a:Lchat/ola/vn/entry/b/s;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x14

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/s$1;->a:Lchat/ola/vn/entry/b/s;

    invoke-static {p1}, Lchat/ola/vn/entry/b/s;->a(Lchat/ola/vn/entry/b/s;)Lchat/ola/vn/i/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->a()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const p2, 0x7f0f009f

    const p3, 0x7f0f024b

    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/s$1;->a:Lchat/ola/vn/entry/b/s;

    invoke-static {v0}, Lchat/ola/vn/entry/b/s;->a(Lchat/ola/vn/entry/b/s;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    const/4 v0, 0x1

    aget-object p1, p1, v0

    check-cast p1, Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v2, 0x2

    invoke-static {v0, v1, p1, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->y(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
