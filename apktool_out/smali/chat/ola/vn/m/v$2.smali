.class Lchat/ola/vn/m/v$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/v;->b(Lchat/ola/vn/entity/e;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/e;

.field final synthetic b:Lchat/ola/vn/m/v;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/v;Lchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/v$2;->b:Lchat/ola/vn/m/v;

    iput-object p2, p0, Lchat/ola/vn/m/v$2;->a:Lchat/ola/vn/entity/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    new-instance p1, Lchat/ola/vn/m/v$2$2;

    invoke-direct {p1, p0}, Lchat/ola/vn/m/v$2$2;-><init>(Lchat/ola/vn/m/v$2;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
    .locals 0

    new-instance p1, Lchat/ola/vn/m/v$2$1;

    invoke-direct {p1, p0, p3}, Lchat/ola/vn/m/v$2$1;-><init>(Lchat/ola/vn/m/v$2;Lchat/ola/vn/entity/e;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method
