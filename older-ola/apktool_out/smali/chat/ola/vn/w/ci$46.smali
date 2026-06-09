.class Lchat/ola/vn/w/ci$46;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->o()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$46;->a:Lchat/ola/vn/w/ci;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x37

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x0

    iput-object v1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    const/4 v1, -0x1

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ae:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$46;->a:Lchat/ola/vn/w/ci;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-static {v1, v0, v2, v3}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
