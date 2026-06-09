.class Lchat/ola/vn/view/OlaGalleryView$2;
.super Landroid/database/DataSetObserver;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/OlaGalleryView;->setAdapter(Landroid/widget/ListAdapter;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/OlaGalleryView;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/OlaGalleryView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaGalleryView$2;->a:Lchat/ola/vn/view/OlaGalleryView;

    invoke-direct {p0}, Landroid/database/DataSetObserver;-><init>()V

    return-void
.end method


# virtual methods
.method public onChanged()V
    .locals 1

    invoke-super {p0}, Landroid/database/DataSetObserver;->onChanged()V

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView$2;->a:Lchat/ola/vn/view/OlaGalleryView;

    invoke-static {v0}, Lchat/ola/vn/view/OlaGalleryView;->a(Lchat/ola/vn/view/OlaGalleryView;)V

    return-void
.end method
