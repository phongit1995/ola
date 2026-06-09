.class public Lchat/ola/vn/entry/a/a;
.super Lchat/ola/vn/entry/a/c;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entry/a/c<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    const/4 v2, 0x4

    move-object v0, p0

    move v1, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/entry/a/c;-><init>(SSLjava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public a(Landroid/content/Context;)Z
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/entry/a/a;->e:Lchat/ola/vn/entry/a/c$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/a/a;->e:Lchat/ola/vn/entry/a/c$a;

    iget-object v0, p0, Lchat/ola/vn/entry/a/a;->d:Ljava/lang/Object;

    invoke-interface {p1, p0, v0}, Lchat/ola/vn/entry/a/c$a;->a(Lchat/ola/vn/entry/a/c;Ljava/lang/Object;)V

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method
