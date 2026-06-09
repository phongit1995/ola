.class public Lchat/ola/vn/entry/a/e;
.super Lchat/ola/vn/entry/a/c;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entry/a/c<",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;)V
    .locals 6

    const/4 v2, 0x0

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
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/entry/a/e;->d:Ljava/lang/Object;

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    const/4 v0, 0x1

    xor-int/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/a/e;->d:Ljava/lang/Object;

    iget-object p1, p0, Lchat/ola/vn/entry/a/e;->e:Lchat/ola/vn/entry/a/c$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/a/e;->e:Lchat/ola/vn/entry/a/c$a;

    iget-object v1, p0, Lchat/ola/vn/entry/a/e;->d:Ljava/lang/Object;

    invoke-interface {p1, p0, v1}, Lchat/ola/vn/entry/a/c$a;->a(Lchat/ola/vn/entry/a/c;Ljava/lang/Object;)V

    :cond_0
    return v0
.end method
