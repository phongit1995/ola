.class public Lchat/ola/vn/m/h;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lcom/google/android/gms/maps/GoogleMap$OnInfoWindowClickListener;
.implements Lcom/google/android/gms/maps/GoogleMap$OnMarkerClickListener;


# static fields
.field public static a:Z = true


# instance fields
.field private b:Lcom/google/android/gms/maps/GoogleMap;

.field private c:Lcom/google/android/gms/maps/model/LatLng;

.field private d:Lcom/google/android/gms/maps/SupportMapFragment;

.field private e:Landroid/widget/ImageView;

.field private f:Landroid/widget/ListView;

.field private g:Lchat/ola/vn/b/af;

.field private h:Landroid/view/animation/Animation;

.field private i:Landroid/view/animation/Animation;

.field private j:Lcom/google/android/gms/maps/model/Marker;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/h;)Lcom/google/android/gms/maps/GoogleMap;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/m/h;Lcom/google/android/gms/maps/GoogleMap;)Lcom/google/android/gms/maps/GoogleMap;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    const/16 v0, 0xb

    invoke-static {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    return-void
.end method

.method private a(Lchat/ola/vn/message/f;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/c/f;->b(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/m/h$3;

    invoke-direct {v1, p0, p1, p2, p3}, Lchat/ola/vn/m/h$3;-><init>(Lchat/ola/vn/m/h;Lchat/ola/vn/message/f;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-instance p1, Lchat/ola/vn/c/e;

    invoke-direct {p1}, Lchat/ola/vn/c/e;-><init>()V

    const/4 p2, 0x1

    new-array p2, p2, [Lchat/ola/vn/c/f;

    const/4 p3, 0x0

    aput-object v0, p2, p3

    invoke-virtual {p1, p2}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Ljava/util/List;Lchat/ola/vn/message/f;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Lchat/ola/vn/message/f;",
            ")V"
        }
    .end annotation

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->n()V

    const/4 v0, 0x0

    if-eqz p2, :cond_1

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/r/a/f;->f:Ljava/lang/String;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->s()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    new-instance v3, Lcom/google/android/gms/maps/model/LatLng;

    invoke-static {v1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v4

    invoke-static {v2}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v1

    invoke-direct {v3, v4, v5, v1, v2}, Lcom/google/android/gms/maps/model/LatLng;-><init>(DD)V

    iput-object v3, p0, Lchat/ola/vn/m/h;->c:Lcom/google/android/gms/maps/model/LatLng;

    iget-object v1, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    iget-object v2, p0, Lchat/ola/vn/m/h;->c:Lcom/google/android/gms/maps/model/LatLng;

    const/high16 v3, 0x40a00000    # 5.0f

    invoke-static {v2, v3}, Lcom/google/android/gms/maps/CameraUpdateFactory;->newLatLngZoom(Lcom/google/android/gms/maps/model/LatLng;F)Lcom/google/android/gms/maps/CameraUpdate;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/android/gms/maps/GoogleMap;->moveCamera(Lcom/google/android/gms/maps/CameraUpdate;)V

    iget-object v1, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    const/high16 v2, 0x41880000    # 17.0f

    invoke-static {v2}, Lcom/google/android/gms/maps/CameraUpdateFactory;->zoomTo(F)Lcom/google/android/gms/maps/CameraUpdate;

    move-result-object v2

    const/16 v3, 0xbb8

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v3, v4}, Lcom/google/android/gms/maps/GoogleMap;->animateCamera(Lcom/google/android/gms/maps/CameraUpdate;ILcom/google/android/gms/maps/GoogleMap$CancelableCallback;)V

    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    :cond_0
    invoke-interface {p1, v0, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_1
    if-eqz p1, :cond_6

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_6

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    :goto_0
    if-ge v0, p2, :cond_6

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    const/4 v3, 0x5

    if-eq v2, v3, :cond_5

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    const/4 v3, 0x6

    if-ne v2, v3, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {v1}, Lchat/ola/vn/message/f;->t()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->s()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_5

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    goto :goto_1

    :cond_3
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v4

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v4

    if-nez v4, :cond_4

    invoke-direct {p0, v1, v2, v3}, Lchat/ola/vn/m/h;->a(Lchat/ola/vn/message/f;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    invoke-static {v5, v4}, Lchat/ola/vn/n/b;->a(Landroid/content/Context;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v4

    if-eqz v4, :cond_5

    new-instance v5, Lcom/google/android/gms/maps/model/LatLng;

    invoke-static {v2}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v6

    invoke-static {v3}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v2

    invoke-direct {v5, v6, v7, v2, v3}, Lcom/google/android/gms/maps/model/LatLng;-><init>(DD)V

    new-instance v2, Lcom/google/android/gms/maps/model/MarkerOptions;

    invoke-direct {v2}, Lcom/google/android/gms/maps/model/MarkerOptions;-><init>()V

    invoke-virtual {v2, v5}, Lcom/google/android/gms/maps/model/MarkerOptions;->position(Lcom/google/android/gms/maps/model/LatLng;)Lcom/google/android/gms/maps/model/MarkerOptions;

    move-result-object v2

    invoke-static {v4}, Lcom/google/android/gms/maps/model/BitmapDescriptorFactory;->fromBitmap(Landroid/graphics/Bitmap;)Lcom/google/android/gms/maps/model/BitmapDescriptor;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/google/android/gms/maps/model/MarkerOptions;->icon(Lcom/google/android/gms/maps/model/BitmapDescriptor;)Lcom/google/android/gms/maps/model/MarkerOptions;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lcom/google/android/gms/maps/model/MarkerOptions;->snippet(Ljava/lang/String;)Lcom/google/android/gms/maps/model/MarkerOptions;

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1, v2}, Lchat/ola/vn/r/a/f;->a(Lcom/google/android/gms/maps/model/MarkerOptions;)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    invoke-virtual {v1, v2}, Lcom/google/android/gms/maps/GoogleMap;->addMarker(Lcom/google/android/gms/maps/model/MarkerOptions;)Lcom/google/android/gms/maps/model/Marker;

    :cond_5
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_6
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/h;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/h;->h()V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/m/h;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/h;->e()V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/m/h;)Landroid/widget/ListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/m/h;)Landroid/view/animation/Animation;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/h;->i:Landroid/view/animation/Animation;

    return-object p0
.end method

.method private e()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/h;->d:Lcom/google/android/gms/maps/SupportMapFragment;

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/h;->d:Lcom/google/android/gms/maps/SupportMapFragment;

    new-instance v1, Lchat/ola/vn/m/h$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/h$1;-><init>(Lchat/ola/vn/m/h;)V

    invoke-virtual {v0, v1}, Lcom/google/android/gms/maps/SupportMapFragment;->getMapAsync(Lcom/google/android/gms/maps/OnMapReadyCallback;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    invoke-direct {p0}, Lchat/ola/vn/m/h;->j()V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/m/h;->j()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/m/h;)Landroid/widget/ImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/h;->e:Landroid/widget/ImageView;

    return-object p0
.end method

.method static synthetic g(Lchat/ola/vn/m/h;)Landroid/view/animation/Animation;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/h;->h:Landroid/view/animation/Animation;

    return-object p0
.end method

.method private h()V
    .locals 5

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    const-string v2, "pivot_contact_id"

    invoke-virtual {v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    :cond_0
    sget-object v3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    iget-object v3, v3, Lchat/ola/vn/r/a/f;->f:Ljava/lang/String;

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    sget-object v3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v3}, Lchat/ola/vn/r/a/f;->m()I

    move-result v3

    if-lez v3, :cond_1

    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/m/h;->v()V

    return-void

    :cond_1
    new-instance v3, Lchat/ola/vn/message/f;

    invoke-direct {v3, v2, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    sget-short v0, Lchat/ola/vn/h;->H:S

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/f;->d(S)V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/f;->k(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {v3, v0}, Lchat/ola/vn/message/f;->j(Ljava/lang/String;)V

    goto :goto_2

    :cond_2
    const-string v2, "pivot_contact_vip_icon_index"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->getShort(Ljava/lang/String;S)S

    move-result v1

    invoke-virtual {v3, v1}, Lchat/ola/vn/message/f;->d(S)V

    const-string v1, "pivot_contact_lat"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Lchat/ola/vn/message/f;->k(Ljava/lang/String;)V

    const-string v1, "pivot_contact_long"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :goto_2
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->h()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_5

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-direct {p0, v1, v3}, Lchat/ola/vn/m/h;->a(Ljava/util/List;Lchat/ola/vn/message/f;)V

    return-void

    :cond_3
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    iget-object v2, v2, Lchat/ola/vn/r/a/f;->f:Ljava/lang/String;

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->m()I

    move-result v0

    if-lez v0, :cond_4

    goto :goto_0

    :cond_4
    new-instance v0, Lchat/ola/vn/message/f;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    sget-short v1, Lchat/ola/vn/h;->H:S

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->d(S)V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->k(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->j(Ljava/lang/String;)V

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->h()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_5

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_5

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-direct {p0, v2, v0}, Lchat/ola/vn/m/h;->a(Ljava/util/List;Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_5
    return-void

    :catch_0
    invoke-direct {p0}, Lchat/ola/vn/m/h;->j()V

    return-void
.end method

.method private j()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private v()V
    .locals 5

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->l()Ljava/util/Iterator;

    move-result-object v0

    if-eqz v0, :cond_0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/google/android/gms/maps/model/MarkerOptions;

    iget-object v2, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    invoke-virtual {v2, v1}, Lcom/google/android/gms/maps/GoogleMap;->addMarker(Lcom/google/android/gms/maps/model/MarkerOptions;)Lcom/google/android/gms/maps/model/Marker;

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Lcom/google/android/gms/maps/model/LatLng;

    invoke-static {v0}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v3

    invoke-static {v1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v0

    invoke-direct {v2, v3, v4, v0, v1}, Lcom/google/android/gms/maps/model/LatLng;-><init>(DD)V

    iput-object v2, p0, Lchat/ola/vn/m/h;->c:Lcom/google/android/gms/maps/model/LatLng;

    goto :goto_1

    :cond_1
    new-instance v0, Lcom/google/android/gms/maps/model/LatLng;

    const-wide v1, 0x4025972452c59fb2L    # 10.795199

    const-wide v3, 0x405aaa79d0a67621L    # 106.663685

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/android/gms/maps/model/LatLng;-><init>(DD)V

    iput-object v0, p0, Lchat/ola/vn/m/h;->c:Lcom/google/android/gms/maps/model/LatLng;

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    iget-object v1, p0, Lchat/ola/vn/m/h;->c:Lcom/google/android/gms/maps/model/LatLng;

    const/high16 v2, 0x41880000    # 17.0f

    invoke-static {v1, v2}, Lcom/google/android/gms/maps/CameraUpdateFactory;->newLatLngZoom(Lcom/google/android/gms/maps/model/LatLng;F)Lcom/google/android/gms/maps/CameraUpdate;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/maps/GoogleMap;->moveCamera(Lcom/google/android/gms/maps/CameraUpdate;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->a(Landroid/os/Bundle;)V

    if-eqz p1, :cond_1

    :try_start_0
    const-string v0, "showFriendList"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    iget-object v0, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    new-instance p1, Lchat/ola/vn/b/af;

    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-direct {p1, v0, v1}, Lchat/ola/vn/b/af;-><init>(Landroid/content/Context;Lchat/ola/vn/r/a/f;)V

    iput-object p1, p0, Lchat/ola/vn/m/h;->g:Lchat/ola/vn/b/af;

    iget-object p1, p0, Lchat/ola/vn/m/h;->g:Lchat/ola/vn/b/af;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/af;->a(Z)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/h;->g:Lchat/ola/vn/b/af;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-static {}, Lcom/google/android/gms/maps/SupportMapFragment;->newInstance()Lcom/google/android/gms/maps/SupportMapFragment;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/h;->d:Lcom/google/android/gms/maps/SupportMapFragment;

    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getChildFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/h;->d:Lcom/google/android/gms/maps/SupportMapFragment;

    const-class v1, Lcom/google/android/gms/maps/SupportMapFragment;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    const v2, 0x7f09032e

    invoke-virtual {p1, v2, v0, v1}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    new-instance v0, Lchat/ola/vn/m/h$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/h$2;-><init>(Lchat/ola/vn/m/h;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public c()V
    .locals 0

    return-void
.end method

.method public d()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public g_()Z
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/m/h;->c()V

    const/4 v0, 0x1

    return v0
.end method

.method public h_()Landroid/app/Dialog;
    .locals 4

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    :try_start_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    invoke-virtual {v2}, Landroid/widget/ListView;->getVisibility()I

    move-result v2

    if-nez v2, :cond_0

    const v2, 0x7f0f016d

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_0
    const v2, 0x7f0f016c

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    invoke-virtual {v2}, Lcom/google/android/gms/maps/GoogleMap;->getMapType()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_1

    const v2, 0x7f0f016e

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_2
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_1
    const v2, 0x7f0f016b

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_2

    :cond_2
    :goto_3
    const v2, 0x7f0f016a

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/h$4;

    invoke-direct {v2, p0, v1}, Lchat/ola/vn/m/h$4;-><init>(Lchat/ola/vn/m/h;Ljava/util/List;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object v0
.end method

.method public i()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900cf

    if-eq p1, v0, :cond_2

    const v0, 0x7f0900fe

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039f

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/h;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/h;->d()I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->d(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/h;->c:Lcom/google/android/gms/maps/model/LatLng;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    iget-object v0, p0, Lchat/ola/vn/m/h;->c:Lcom/google/android/gms/maps/model/LatLng;

    invoke-static {v0}, Lcom/google/android/gms/maps/CameraUpdateFactory;->newLatLng(Lcom/google/android/gms/maps/model/LatLng;)Lcom/google/android/gms/maps/CameraUpdate;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/google/android/gms/maps/GoogleMap;->animateCamera(Lcom/google/android/gms/maps/CameraUpdate;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/h;->i:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->e:Landroid/widget/ImageView;

    const v0, 0x7f080637

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/h;->h:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->e:Landroid/widget/ImageView;

    const v0, 0x7f080638

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->j:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {p1}, Lcom/google/android/gms/maps/model/Marker;->hideInfoWindow()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0b00d2

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1, p3, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p3, 0x7f0900fe

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    invoke-virtual {p3, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p3, 0x7f09039f

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    invoke-virtual {p3, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p3, 0x7f0903a0

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/ImageView;

    const v0, 0x7f080794

    invoke-virtual {p3, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    const p3, 0x7f0903a3

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/TextView;

    const v0, 0x7f0f00e5

    invoke-virtual {p3, v0}, Landroid/widget/TextView;->setText(I)V

    const p3, 0x7f0900cf

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/ImageView;

    iput-object p3, p0, Lchat/ola/vn/m/h;->e:Landroid/widget/ImageView;

    iget-object p3, p0, Lchat/ola/vn/m/h;->e:Landroid/widget/ImageView;

    invoke-virtual {p3, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p3, 0x7f09031d

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/ListView;

    iput-object p3, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    iget-object p3, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    invoke-virtual {p3, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    sget-object p3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    if-eqz p3, :cond_0

    sget-object p3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p3}, Lchat/ola/vn/r/a/f;->g()I

    move-result p3

    if-nez p3, :cond_1

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/h;->c()V

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    const v0, 0x7f01004b

    invoke-static {p3, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p3

    iput-object p3, p0, Lchat/ola/vn/m/h;->h:Landroid/view/animation/Animation;

    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    const v0, 0x7f01004f

    invoke-static {p3, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p3

    iput-object p3, p0, Lchat/ola/vn/m/h;->i:Landroid/view/animation/Animation;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    return-object p2
.end method

.method public onDetach()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    invoke-virtual {v0}, Lcom/google/android/gms/maps/GoogleMap;->stopAnimation()V

    iget-object v0, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    invoke-virtual {v0}, Lcom/google/android/gms/maps/GoogleMap;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    return-void
.end method

.method public onInfoWindowClick(Lcom/google/android/gms/maps/model/Marker;)V
    .locals 2

    invoke-virtual {p1}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/h;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0, v1, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 2
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
    iget-object p1, p0, Lchat/ola/vn/m/h;->g:Lchat/ola/vn/b/af;

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/af;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    new-instance p2, Lcom/google/android/gms/maps/model/LatLng;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->t()Ljava/lang/String;

    move-result-object p3

    invoke-static {p3}, Ljava/lang/Double;->valueOf(Ljava/lang/String;)Ljava/lang/Double;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/Double;->doubleValue()D

    move-result-wide p3

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->s()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Double;->valueOf(Ljava/lang/String;)Ljava/lang/Double;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v0

    invoke-direct {p2, p3, p4, v0, v1}, Lcom/google/android/gms/maps/model/LatLng;-><init>(DD)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->b:Lcom/google/android/gms/maps/GoogleMap;

    invoke-static {p2}, Lcom/google/android/gms/maps/CameraUpdateFactory;->newLatLng(Lcom/google/android/gms/maps/model/LatLng;)Lcom/google/android/gms/maps/CameraUpdate;

    move-result-object p2

    const/16 p3, 0x96

    const/4 p4, 0x0

    invoke-virtual {p1, p2, p3, p4}, Lcom/google/android/gms/maps/GoogleMap;->animateCamera(Lcom/google/android/gms/maps/CameraUpdate;ILcom/google/android/gms/maps/GoogleMap$CancelableCallback;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onMarkerClick(Lcom/google/android/gms/maps/model/Marker;)Z
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/m/h;->j:Lcom/google/android/gms/maps/model/Marker;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/h;->i:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/m/h;->e:Landroid/widget/ImageView;

    const v0, 0x7f080637

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    :try_start_0
    const-string v0, "showFriendList"

    iget-object v1, p0, Lchat/ola/vn/m/h;->f:Landroid/widget/ListView;

    invoke-virtual {v1}, Landroid/widget/ListView;->getVisibility()I

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method
