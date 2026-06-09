.class Lchat/ola/vn/activity/OlaImageViewerActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Lchat/ola/vn/mediastore/OlaMediaEntity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/mediastore/OlaMediaEntity;

.field final synthetic c:Lchat/ola/vn/activity/OlaImageViewerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Ljava/util/List;Lchat/ola/vn/mediastore/OlaMediaEntity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

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

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p3, 0x7f0f0491

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x5

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-static {p1, p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    :goto_1
    sput p3, Lchat/ola/vn/h;->G:I

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "#\u001b"

    invoke-virtual {p2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p4}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p4, "#"

    invoke-virtual {p2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p4, 0x7f0f0493

    invoke-virtual {p2, p4}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p4, 0x1

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    if-eq p1, p4, :cond_1

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "##"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_2

    :cond_2
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " ##"

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#"

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_1

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p3, 0x7f0f05f8

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    if-eq p1, p4, :cond_5

    const/4 p2, 0x3

    if-eq p1, p2, :cond_4

    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->f(Ljava/lang/String;)V

    return-void

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$5;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/b/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    const/4 p1, 0x0

    sput p1, Lchat/ola/vn/h;->G:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
