.class Lchat/ola/vn/w/ci$55;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(B)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:B

.field final synthetic b:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;B)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$55;->b:Lchat/ola/vn/w/ci;

    iput-byte p2, p0, Lchat/ola/vn/w/ci$55;->a:B

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x92

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-byte v1, p0, Lchat/ola/vn/w/ci$55;->a:B

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    iget-object v1, p0, Lchat/ola/vn/w/ci$55;->b:Lchat/ola/vn/w/ci;

    const/4 v2, 0x1

    invoke-static {v1, v0, v2, v2}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
