.class Lchat/ola/vn/m/g$7;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;Lchat/ola/vn/p/b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/e;

.field final synthetic b:Lchat/ola/vn/p/b;

.field final synthetic c:Lchat/ola/vn/m/g;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/g;Lchat/ola/vn/entity/e;Lchat/ola/vn/p/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    iput-object p2, p0, Lchat/ola/vn/m/g$7;->a:Lchat/ola/vn/entity/e;

    iput-object p3, p0, Lchat/ola/vn/m/g$7;->b:Lchat/ola/vn/p/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/m/g$7$2;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/m/g$7$2;-><init>(Lchat/ola/vn/m/g$7;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/m/g$7$1;

    invoke-direct {v0, p0, p3, p1, p2}, Lchat/ola/vn/m/g$7$1;-><init>(Lchat/ola/vn/m/g$7;Lchat/ola/vn/entity/e;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method
