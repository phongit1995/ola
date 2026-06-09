.class public Lchat/ola/vn/entry/a/c;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/entry/a/c$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field protected a:S

.field protected b:Ljava/lang/String;

.field protected c:Ljava/lang/String;

.field protected d:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field protected e:Lchat/ola/vn/entry/a/c$a;

.field private f:S


# direct methods
.method public constructor <init>(SSLjava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(SS",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "TT;)V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-short p1, p0, Lchat/ola/vn/entry/a/c;->a:S

    iput-short p2, p0, Lchat/ola/vn/entry/a/c;->f:S

    iput-object p3, p0, Lchat/ola/vn/entry/a/c;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/entry/a/c;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/entry/a/c;->d:Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entry/a/c$a;",
            ")",
            "Lchat/ola/vn/entry/a/c<",
            "TT;>;"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entry/a/c;->e:Lchat/ola/vn/entry/a/c$a;

    return-object p0
.end method

.method public a()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/entry/a/c;->a:S

    return v0
.end method

.method public a(Landroid/content/Context;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/a/c;->b:Ljava/lang/String;

    return-object v0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/a/c;->c:Ljava/lang/String;

    return-object v0
.end method

.method public d()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/entry/a/c;->f:S

    return v0
.end method

.method public e()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entry/a/c;->d:Ljava/lang/Object;

    return-object v0
.end method
