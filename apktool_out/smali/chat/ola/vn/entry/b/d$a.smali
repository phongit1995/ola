.class Lchat/ola/vn/entry/b/d$a;
.super Lchat/ola/vn/entity/n;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/entry/b/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Ljava/lang/String;

.field b:S

.field final synthetic c:Lchat/ola/vn/entry/b/d;


# direct methods
.method public constructor <init>(Lchat/ola/vn/entry/b/d;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/d$a;->c:Lchat/ola/vn/entry/b/d;

    invoke-direct {p0}, Lchat/ola/vn/entity/n;-><init>()V

    iput-object p2, p0, Lchat/ola/vn/entry/b/d$a;->a:Ljava/lang/String;

    iput-short p3, p0, Lchat/ola/vn/entry/b/d$a;->b:S

    return-void
.end method


# virtual methods
.method public a(Landroid/content/Context;)Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/b/d$a;->a:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/entry/b/d$a;->b:S

    invoke-static {p1, v0, v1}, Lchat/ola/vn/entry/b/d;->a(Landroid/content/Context;Ljava/lang/String;S)V

    const/4 p1, 0x1

    return p1
.end method
