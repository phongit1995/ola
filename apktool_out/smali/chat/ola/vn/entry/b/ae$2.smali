.class Lchat/ola/vn/entry/b/ae$2;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/ae;->h()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/entry/b/ae;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/ae;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/ae$2;->b:Lchat/ola/vn/entry/b/ae;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ae$2;->a:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x4b

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object p2, p0, Lchat/ola/vn/entry/b/ae$2;->a:Ljava/lang/String;

    const/4 p4, 0x0

    invoke-virtual {p1, p2, p4}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_0

    const-string p2, "received-tradding-vip"

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->o(Ljava/lang/String;)Lchat/ola/vn/message/d;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/q;

    if-eqz p1, :cond_0

    invoke-virtual {p1, p3}, Lchat/ola/vn/message/q;->a(Ljava/lang/String;)V

    invoke-virtual {p1, p4}, Lchat/ola/vn/message/q;->c(B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 0

    return-void
.end method
