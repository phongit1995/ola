.class Lchat/ola/vn/m/o$4$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/i/h$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o$4;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/o$4;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o$4;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$4$2;->a:Lchat/ola/vn/m/o$4;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Z)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/m/o$4$2;->a:Lchat/ola/vn/m/o$4;

    iget-object v1, v1, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/message/f;Z)Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
