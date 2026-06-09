.class final Lchat/ola/vn/activity/OlaCropImageActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;IILchat/ola/vn/activity/OlaCropImageActivity$b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:I

.field final synthetic c:I


# direct methods
.method constructor <init>(Landroid/content/Context;II)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->a:Landroid/content/Context;

    iput p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->b:I

    iput p3, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->c:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    const/4 p1, 0x0

    packed-switch p3, :pswitch_data_0

    return-void

    :pswitch_0
    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->a:Landroid/content/Context;

    iget p3, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->b:I

    iget p4, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->c:I

    const/4 p5, 0x2

    :goto_0
    invoke-static {p2, p1, p3, p4, p5}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Landroid/net/Uri;III)V

    return-void

    :pswitch_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->a:Landroid/content/Context;

    iget p3, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->b:I

    iget p4, p0, Lchat/ola/vn/activity/OlaCropImageActivity$5;->c:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p5, 0x1

    goto :goto_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
