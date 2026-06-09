.class Lchat/ola/vn/w/ci$27;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Z

.field final synthetic d:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$27;->d:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$27;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/ci$27;->b:Ljava/lang/String;

    iput-boolean p4, p0, Lchat/ola/vn/w/ci$27;->c:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x4f

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$27;->a:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$27;->b:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iget-boolean v1, p0, Lchat/ola/vn/w/ci$27;->c:Z

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    iget-object v1, p0, Lchat/ola/vn/w/ci$27;->d:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
