.class Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaImageViewerActivity$a;->instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/mediastore/OlaMediaEntity;

.field final synthetic b:Lchat/ola/vn/activity/OlaImageViewerActivity$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaImageViewerActivity$a;Lchat/ola/vn/mediastore/OlaMediaEntity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->b:Lchat/ola/vn/activity/OlaImageViewerActivity$a;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->a:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->a:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->b:Lchat/ola/vn/activity/OlaImageViewerActivity$a;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->a:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->e(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->b:Lchat/ola/vn/activity/OlaImageViewerActivity$a;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->a:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->b(Landroid/content/Context;Landroid/net/Uri;)V

    return-void

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->b:Lchat/ola/vn/activity/OlaImageViewerActivity$a;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;->a:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->f(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
