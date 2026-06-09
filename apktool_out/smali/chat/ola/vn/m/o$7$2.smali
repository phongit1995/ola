.class Lchat/ola/vn/m/o$7$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o$7;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/o$7;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o$7;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$7$2;->a:Lchat/ola/vn/m/o$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    if-eqz p2, :cond_1

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2}, Lchat/ola/vn/message/g;->a()V

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/m/o$7$2;->a:Lchat/ola/vn/m/o$7;

    iget-object p2, p2, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    invoke-static {p2}, Lchat/ola/vn/m/o;->b(Lchat/ola/vn/m/o;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
