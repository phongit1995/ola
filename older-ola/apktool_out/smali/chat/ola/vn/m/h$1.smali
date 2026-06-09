.class Lchat/ola/vn/m/h$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/maps/OnMapReadyCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/h;->e()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/h;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/h;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onMapReady(Lcom/google/android/gms/maps/GoogleMap;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-static {v0, p1}, Lchat/ola/vn/m/h;->a(Lchat/ola/vn/m/h;Lcom/google/android/gms/maps/GoogleMap;)Lcom/google/android/gms/maps/GoogleMap;

    iget-object p1, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->a(Lchat/ola/vn/m/h;)Lcom/google/android/gms/maps/GoogleMap;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/b/d;

    iget-object v1, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-virtual {v1}, Lchat/ola/vn/m/h;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/b/d;-><init>(Landroid/content/Context;Landroid/view/View$OnClickListener;)V

    invoke-virtual {p1, v0}, Lcom/google/android/gms/maps/GoogleMap;->setInfoWindowAdapter(Lcom/google/android/gms/maps/GoogleMap$InfoWindowAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->a(Lchat/ola/vn/m/h;)Lcom/google/android/gms/maps/GoogleMap;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/maps/GoogleMap;->setOnMarkerClickListener(Lcom/google/android/gms/maps/GoogleMap$OnMarkerClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->a(Lchat/ola/vn/m/h;)Lcom/google/android/gms/maps/GoogleMap;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/maps/GoogleMap;->setOnInfoWindowClickListener(Lcom/google/android/gms/maps/GoogleMap$OnInfoWindowClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/h$1;->a:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->b(Lchat/ola/vn/m/h;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
